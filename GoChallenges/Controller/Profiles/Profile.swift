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
    
    
    @IBOutlet weak var currentChallengeButton: UIButton!
    @IBOutlet weak var completedChallengeButton: UIButton!
    @IBOutlet weak var friendButton: UIButton!
    
    
    @IBOutlet weak var changeProfileButton: UIButton!
    @IBOutlet weak var addFriendButton: UIButton!
    
    internal var userID : String!
    
    let currentUser = Auth.auth().currentUser as! User
    var profile : QueryDocumentSnapshot!
    var friends : [QueryDocumentSnapshot]!

    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadProfile()
        //hideFeatures()
    }
    
    // Load the current user profile
    private func loadProfile() {
        let profileRef = db.collection(K.profiles)
        let email = currentUser.email
        let query = profileRef.whereField("email", isEqualTo: email!)
        
        query.getDocuments { (querySnapshots, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                self.profile = querySnapshots!.documents[0]
                
                self.userID = self.profile.documentID
                
                let username = self.profile[K.profile.name] as! String
                let currentChallenges = self.profile[K.profile.current] as! NSDictionary
                let completeChallenges = self.profile[K.profile.finished] as! NSArray
                self.friends = self.profile[K.profile.friends] as! [QueryDocumentSnapshot]
                
                self.username.text = username
                self.currentChallengeButton.setTitle("\(currentChallenges.count)", for: .normal)
                self.completedChallengeButton.setTitle("\(completeChallenges.count)", for: .normal)
                self.friendButton.setTitle("\(self.friends!.count)", for: .normal)
                
                if let imageURLString = self.profile[K.profile.image] {
                    let imageURL = URL(string: imageURLString as! String)
                    self.profileImageView.af.setImage(withURL: imageURL!)
                    
                self.hideFeatures()
                }
            }
        }
    }
    
    // Hide the Add friend and Add Profile Image Features
    func hideFeatures() {
        
        // Not current user's profile
        if profile["email"] as! String != currentUser.email {
            
            // Hide change profile picture button and show add friend button
            changeProfileButton.isHidden = true
            addFriendButton.isHidden = false
            
            // Check if added friend
            if self.friends.isEmpty != false {
                addFriendButton.isHidden = friends.contains(profile) ? true : false
            } else {
                addFriendButton.isHidden = false
            }

        } else {
            changeProfileButton.isHidden = false
            addFriendButton.isHidden = true
        }
    }
    
    //MARK: - Add Friend
    @IBAction func addFriend(_ sender: Any) {
        do {
            try friends!.append(profile)
        } catch {
            friends = [profile]
        }

        // Update the friends array of Profile object
        let db = Firestore.firestore()
        let profileRef = db.collection("Profiles").document(self.userID)
        profileRef.updateData([K.profile.friends:friends]) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Added friend")
            }
        }
    }
    
    //MARK: - Add Profile Image

    @IBAction func addProfileImage(_ sender: Any) {
        performSegue(withIdentifier: K.profileToCamera, sender: sender)
    }
    

    //MARK: - Perform Segue to Table View
    @IBAction func toTableView(_ sender: Any) {
        performSegue(withIdentifier: K.segue.profileToTB, sender: sender)
    }
}

//MARK: - Prepare for segues

extension Profile {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.profileToCamera {
            let navigationVC = segue.destination as! UINavigationController
            let vc = navigationVC.topViewController as! CameraViewController
            
            vc.userID = userID
        }
    }
}

