//  ChallengesFeed.swift
//  GoChallenges

import UIKit
import Firebase

class ChallengesFeed: UIViewController {

    @IBOutlet weak var challengeTableView: UITableView!

    
    
    let db = Firestore.firestore()
    var categoryFilter : String = ""
    var challengeDict = [QueryDocumentSnapshot]()
    //var challengeList = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        challengeTableView.dataSource = self

        loadData()
        //checkForUpdates()
        
    }
    
    func loadData(){
        db.collection("Food").getDocuments { (querySnapshot, error) in
            if error != nil{
                print(error?.localizedDescription)
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

//MARK: - Table View Data Source
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
        
        cell.textLabel?.text = challenge["Challenge Name"] as! String
        cell.detailTextLabel?.text = "\(challenge["time"] ?? "none")"
        
        return cell
    }

}
