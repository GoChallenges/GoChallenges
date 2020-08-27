//
//  ListTableView.swift
//  GoChallenges
//
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit
import Firebase

class ListTableView: UIViewController, UITableViewDelegate{
    
    let segueDict = [K.friendCell : K.segue.TBToProfile,
                     K.createdCell: K.segue.TBToChallengeDetail
    ]
    
    var cellIdentifer : String!
    var segueIdentifer : String {
        return segueDict[cellIdentifer]!
    }
    
    let db = Firestore.firestore()
    var myProfileID = sessionData.profileID! // Profile ID of selected friend
    var createdChallenges = [DocumentReference]() // Array of created challenges
    var finishedChallenges = [DocumentReference]() // Array of finished challenges
    var friends = [DocumentReference]() // Array of friends
    var emails = [String]() // Array of friends' emails
    
    var selectedRow = 0
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: K.friendCellNib, bundle: nil), forCellReuseIdentifier: cellIdentifer)
        listTableView.rowHeight = 80
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // Load arrays depending on Cell Identifer
        if cellIdentifer == K.friendCell {
            loadFriends()
        } else if cellIdentifer == K.createdCell {
            loadCreatedChallenges()
        }
    }
    
    // Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the user is viewing friend list
        let vc = segue.destination as! Profile
        
            // Get the email of the profile at selected cell
            let email = emails[selectedRow]
            vc.email = email
        
        // If the user chose to view challenges
        
        
    }
    
    // Load friends array
    func loadFriends() {
        let profileRef = db.collection("Profiles").document(myProfileID)
        profileRef.getDocument { (documentSnapshots, error) in
            if let documentSnapshots = documentSnapshots {
                let data = documentSnapshots.data()
                self.friends = data![K.profile.friends] as! [DocumentReference]
                self.listTableView.reloadData()
                
            } else {
                self.displayErrorAlert(error: error!)
            }
        }
    }
    
    // Load created challenges array
    func loadCreatedChallenges() {
        let profileRef = db.collection("Profiles").document(myProfileID)
        profileRef.getDocument { (documentSnapshots, error) in
            if let documentSnapshots = documentSnapshots {
                let data = documentSnapshots.data()
                self.createdChallenges = data![K.profile.created] as! [DocumentReference]
                self.listTableView.reloadData()
                
            } else {
                self.displayErrorAlert(error: error!)
            }
        }
    }
    
    // Load finised challenges array
    func loadFinishedChallenges() {
        let profileRef = db.collection("Profiles").document(myProfileID)
        profileRef.getDocument { (documentSnapshots, error) in
            if let documentSnapshots = documentSnapshots {
                let data = documentSnapshots.data()
                self.finishedChallenges = data![K.profile.finished] as! [DocumentReference]
                self.listTableView.reloadData()
                
            } else {
                self.displayErrorAlert(error: error!)
            }
        }
    }
}

extension ListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch cellIdentifer {
        case K.friendCell:
            return friends.count
        case K.createdCell:
            return createdChallenges.count
        default:
            return finishedChallenges.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // FriendCell
        getFriendCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cellIdentifer{
            // If the cell is ChallengeCell, go to Detail
            case K.createdCell:
                performSegue(withIdentifier: K.segue.TBToChallengeDetail, sender: self)
            
            // If the cell is FriendCell, go to Profile
            case K.friendCell:
                selectedRow = indexPath.row
                performSegue(withIdentifier: K.segue.TBToProfile, sender: self)
            
            // If the cell is FinishedChallengeCell, return
            default:
                return
            }
        }
}

//MARK: - Create cell functions
extension ListTableView {
    func getFriendCell(indexPath: IndexPath) -> FriendCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! FriendCell
        
        let friendRef = friends[indexPath.row] // Ref to friend's profile
        friendRef.getDocument { (documents, error) in
            if let friend = documents {
                // Add email to emails array
                let email = friend[K.profile.email] as! String
                self.emails.append(email)
                // Profile's display name
                cell.displayNameLabel.text = friend[K.profile.name] as! String
                
                // Display profile image
                if let imageURLString = friend[K.profile.image] {
                    let imageURL = URL(string: imageURLString as! String)
                    cell.profileImageView.af.setImage(withURL: imageURL!)
                    
                }
            }
        }
        return cell
    }
    
    func getChallengeCell(indexPath: IndexPath) -> CreatedChallengeCell{
        let cell = listTableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! CreatedChallengeCell
        return cell
    }
    
    func getFinishedChallengeCell(indexPath: IndexPath) -> FinishedChallengeCell{
        let cell = listTableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! FinishedChallengeCell
        return cell
    }
}
