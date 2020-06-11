//
//  Profile.swift
//  GoChallenges
//
//  Created by nguyen thy on 6/1/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import AlamofireImage

class Profile: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var joinedDate: UILabel!
    @IBOutlet weak var currentChalLabel: UILabel!
    @IBOutlet weak var completeChalLabel: UILabel!
    @IBOutlet weak var friendsLabel: UILabel!
    
    let currentUser = Auth.auth().currentUser
    var otherUser : User!
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        loadProfile()
        let profileRef = db.collection(K.profiles)
        let email = currentUser?.email
        let query = profileRef.whereField("email", isEqualTo: email!)
        
        query.getDocuments { (querySnapshots, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                let profile = querySnapshots!.documents[0]
                let username = profile[K.profile.name] as! String
                let currentChallenges = profile[K.profile.current] as! NSDictionary
                let completeChallenges = profile[K.profile.finished] as! NSDictionary
                let friends = profile[K.profile.friends] as! NSArray
                
                self.username.text = username 
                self.currentChalLabel.text = "\(currentChallenges.count)"
                self.completeChalLabel.text = "\(completeChallenges.count)"
                self.friendsLabel.text = "\(friends.count)"
            }
        }
        
        if let user = currentUser {
            let displayName = user.displayName!
            if let imageUrl = user.photoURL {
                profileImageView.af_setImage(withURL: imageUrl)
            }
            
            
            print(displayName)
        }
    }
    
//    func loadProfile() {
//        // Current user profile
//        if currentUser == otherUser {
//            let profileRef = db.collection(K.profiles)
//            let email = currentUser?.email
//            let query = profileRef.whereField("email", isEqualTo: email!)
//
//            query.getDocuments { (querySnapshots, error) in
//                if let error = error {
//                    print("Error: \(error)")
//                } else {
//                    let profile = querySnapshots!.documents[0]
//                    let username = profile[K.profile.name] as! String
//                    let currentChallenges = profile[K.profile.current] as! NSArray
//                    let completeChallenges = profile[K.profile.finished] as! NSArray
//                    let friends = profile[K.profile.friends] as! NSArray
//
//                    self.username.text = username as! String
//                    self.currentChalLabel.text = "\(currentChallenges.count)"
//                    self.completeChalLabel.text = "\(completeChallenges.count)"
//                    self.friendsLabel.text = "\(friends.count)"
//                }
//            }
//        } else {
//
//        // Other's profile
//
//        }
//    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    //MARK: - Add Profile Image

    @IBAction func addProfileImage(_ sender: Any) {
        performSegue(withIdentifier: "profileToCamera", sender: sender)
    }
}

