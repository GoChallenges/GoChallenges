//  ChallengesFeed.swift
//  GoChallenges

import UIKit
import Firebase

class ChallengesFeed: UIViewController {

    @IBOutlet weak var challengeTableView: UITableView!

    
    
    let db = Firestore.firestore()
    var categoryFilter : String = ""
    var challengeDict = [QueryDocumentSnapshot]()
    
    //variables to pass to the next view controller file
    var passDescrip : String = "" //description
    var passName : String = "" //name
    
    //Variables to turn Firestore Timestamp to Date
    var startTimestamp = Timestamp()
    var endTimestamp = Timestamp()
    
    //Date variables
    var startDay = Date()
    var endDay = Date()
    var currentDay = Date()
    var remainingDays : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        challengeTableView.dataSource = self
        challengeTableView.delegate = self
        loadData()
        //checkForUpdates()
    }
    
    func loadData(){
        db.collection("Food").getDocuments { (querySnapshot, error) in
            if error != nil{
                print(error?.localizedDescription as Any)
            }else{
                self.challengeDict = querySnapshot!.documents
                self.challengeTableView.reloadData()
                
            }
        }
    }
    
    //realtime update here
    //Update when having a new challenge created
    /*
    func checkForUpdates(){
        //only querying what happpened after this function runs for the first time
        db.collection("Food").whereField("timeStamp", isGreaterThan: Date())
            // this will listen for the changes to the challengeList
            .addSnapshotListener {
                querySnapshot, error in
                
                guard let snapshot = querySnapshot else {return}
                
                snapshot.documentChanges.forEach {
                    diff in
                    
                    //everytime new thing being added
                    if diff.type == .added{
                        self.challengeList.append((Data(dictionary: diff.document.data()))!)
                        DispatchQueue.main.async {
                            self.challengeTableView.reloadData()
                        }
                    }
                }
        }
        
        
    }
    */

}

//MARK: - Table View Data Source and Delegate
extension  ChallengesFeed : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challengeDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.challengeCell, for: indexPath)
        
        let challenge = challengeDict[indexPath.row]
        
        cell.textLabel?.text = (challenge["Challenge Name"] as! String)
        cell.detailTextLabel?.text = "\(challenge["time"] ?? "none")"
        
        return cell
    }
    
}

extension ChallengesFeed : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let challenge = challengeDict[indexPath.row]
    
        passDescrip = challenge["Challenge Description"] as! String
        passName = challenge["Challenge Name"] as! String
        
        //Convert Firestore Timestamp to Date or NSDate
        startTimestamp = challenge["Start Date"] as! Timestamp
        startDay = startTimestamp.dateValue()
        endTimestamp = challenge["End Date"] as! Timestamp
        endDay = endTimestamp.dateValue() //turn to Date
        
        //if statement to get the remaining days to complete the challenge
        if currentDay > startDay && currentDay < endDay{
            remainingDays = String(Calendar.current.dateComponents([.day], from: currentDay, to: endDay).day!)

        }else if currentDay <= startDay{
            remainingDays = String(Calendar.current.dateComponents([.day], from: startDay, to: endDay).day!)
        }else if currentDay == endDay{
            remainingDays = "0"
        }else if currentDay > endDay{
            remainingDays = "The challenge is expired"
        }
        // need to check when current day is greater than the endDay in the future
        
        //Transfer the challenge's data to the next view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "detailView") as! ChallengeDetail
        detailVC.descriptionText = passDescrip
        detailVC.nameText = passName
        
        //Convert Date to String for start and end dates
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        detailVC.startDate = formatter.string(from: startDay)
        detailVC.endDate = formatter.string(from: endDay)
        detailVC.daysLeft = remainingDays
        
        self.present(detailVC, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true) //stop highlight the cell after select
    }
}