//  ChallengesFeed.swift
//  GoChallenges

import UIKit
import Firebase
import iOSDropDown

class ChallengesFeed: UIViewController {

    @IBOutlet weak var challengeTableView: UITableView!
    @IBOutlet weak var categoryMenu: DropDown!
    
    let db = Firestore.firestore()
    var categoryFilter : String = ""
    var challengeDict = [QueryDocumentSnapshot]()
    
    // Current User and store it to SessionDta class
    let currentUser = Auth.auth().currentUser as! User
    
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
        //Drop down menu
        categoryMenu.optionArray = ["Lifestyle", "Food", "Sport", "Game", "Music", "Education", "Finance"]
        categoryMenu.selectedRowColor = #colorLiteral(red: 0.9909999967, green: 0.3540000021, blue: 0, alpha: 1)
        categoryMenu.checkMarkEnabled = false //check mark when selected
        categoryMenu.isSearchEnable = false //No search function
        
        challengeTableView.dataSource = self
        challengeTableView.delegate = self
        
        sessionData.currentUser = currentUser // Save currentUser to background
        
        //Occur when user select a category
        categoryMenu.didSelect{(selectedText , index ,id) in
            self.loadDataByCategory(selectedText)
        }
    }
    
    //Load all challenges when the screen first show
    override func viewWillAppear(_ animated: Bool) {
        loadDataByCategory("")
    }
    
    //Load challenge based on the category the user selected
    func loadDataByCategory(_ category: String){
        if category == ""{
            let challengesRef  = db.collection("Challenges") // Reference to Challenges collection
            challengesRef.getDocuments { (querySnapshot, error) in
                if error != nil{
                    print(error?.localizedDescription as Any)
                }else{
                    self.challengeDict = querySnapshot!.documents
                    self.challengeTableView.reloadData()
                    
                }
            }
        }else{
            let challengesRef  = db.collection("Challenges") // Reference to Challenges collection
            let query = challengesRef.whereField("Category", isEqualTo: category) // Load challenges with category
            query.getDocuments { (querySnapshot, error) in
                if error != nil{
                    print(error?.localizedDescription as Any)
                }else{
                    self.challengeDict = querySnapshot!.documents
                    self.challengeTableView.reloadData()
                    
                }
            }
        }
    }
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
        //Pass data to the challenge detail screen
        let challenge = challengeDict[indexPath.row]

        let passDescrip = challenge["Challenge Description"] as! String
        let passName = challenge["Challenge Name"] as! String
        let passGoal = challenge["Goal"] as! Double
        let passUnit = challenge["Unit"] as! String
        
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
        detailVC.goal = passGoal
        detailVC.unit = passUnit
        detailVC.docID = challenge.documentID //Pass documentID to update the data later
        
        //Send the creator email to challenge detail screen
        let creatorEmail = challenge["Creator"] as! String // Email (string) of the selected challenge
        detailVC.creatorEmail = creatorEmail 
        
        //Move to the challenge detail screen
        self.present(detailVC, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true) //stop highlight the cell after select
    }
}

//MARK: - Load Current / Creator Profile
extension ChallengesFeed {
    func loadProfile() {
        let dataRef = db.collection("Profiles") // Reference to Profiles collection
        let query = dataRef.whereField("email", isEqualTo: currentUser.email!) // Query all documents with current user's email
        query.getDocuments { (querySnapshots, error) in
            if let e = error {
                self.displayErrorAlert(error: e) // Display an error message
            } else {
                // querySnapshots has only 1 element
                let profile = querySnapshots!.documents[0]
                sessionData.profileID = profile.documentID // Save profile id to background
            }
        }
    }
}
