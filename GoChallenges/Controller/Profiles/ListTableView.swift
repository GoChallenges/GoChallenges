//
//  ListTableView.swift
//  GoChallenges
//
//  Created by nguyen thy on 8/2/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit
import Firebase

class ListTableView: UIViewController, UITableViewDelegate{
    
    let segueDict = [K.friendCell : K.segue.TBToProfile,
                     K.challengeCell: K.segue.TBToChallengeDetail
    ]
    
    var cellIdentifer : String!
    var segueIdentifer : String {
        return segueDict[cellIdentifer]!
    }
    
    let db = Firestore.firestore()
    let myProfileID = sessionData.profileID!
    var challenges = [DocumentReference]()
    var friends = [DocumentReference]()
    
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
        loadFriends()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // Load friends array
    func loadFriends() {
        let profileRef = db.collection("Profiles").document(myProfileID)
        profileRef.getDocument { (documentSnapshots, error) in
            if let documentSnapshots = documentSnapshots {
                let data = documentSnapshots.data()
                self.friends = data!["friends"] as! [DocumentReference]
                self.listTableView.reloadData()
            } else {
                self.displayErrorAlert(error: error!)
            }
        }
    }
    
}

extension ListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellIdentifer == K.friendCell {
            return friends.count
        } else {
            return challenges.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // FriendCell
        let cell = listTableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! FriendCell
        
        let friendRef = friends[indexPath.row] // Ref to friend's profile
        friendRef.getDocument { (documents, error) in
            if let friend = documents {
                cell.displayNameLabel.text = friend[K.profile.name] as! String // Profile's display name
                
                // Display profile image
                if let imageURLString = friend[K.profile.image] {
                    let imageURL = URL(string: imageURLString as! String)
                    cell.profileImageView.af.setImage(withURL: imageURL!)
                }
            }
        }
        return cell
    }
}
