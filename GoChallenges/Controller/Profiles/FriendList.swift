//
//  FriendList.swift
//  GoChallenges
//
//  Created by nguyen thy on 8/31/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit
import Firebase
class FriendList: UIViewController {
    @IBOutlet weak var friendTableView: UITableView!
    
    let db = Firestore.firestore()
    var profileID = "0" // String Id of current user
    var friends = [DocumentReference]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendTableView.delegate = self
        friendTableView.dataSource = self
        friendTableView.register(UINib(nibName: K.friendCellNib, bundle: nil), forCellReuseIdentifier: K.friendCell)
        friendTableView.rowHeight = 100
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
    
    // Query this profile to get Friends array
    func loadFriends() {
        let profileRef = db.collection("Profiles").document(profileID)
        profileRef.getDocument { (documentSnapshots, error) in
            if let data = documentSnapshots?.data() {
                self.friends = data[K.profile.friends] as! [DocumentReference]
                self.friendTableView.reloadData()
            } else {
                let error = error
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
}

//MARK: - TableView datasource

extension FriendList: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendTableView.dequeueReusableCell(withIdentifier: K.friendCell, for: indexPath) as! FriendCell
        let friendRef = friends[indexPath.row] // Ref to profile
        friendRef.getDocument { (documentSnapshots, error) in
            if let friend = documentSnapshots {
                
                // Display profile's name
                let name = friend[K.profile.name] as! String
                cell.displayNameLabel.text = name
                
                // Display profile image
                if let imageURLString = friend[K.profile.image] {
                    let imageURL = URL(string: imageURLString as! String)
                    cell.profileImageView.af.setImage(withURL: imageURL!)
                }
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
        return cell
    }
    
    
}
