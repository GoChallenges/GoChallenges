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

class Profile: UIViewController, UITableViewDelegate {
    
    // UI Element Outlets
    @IBOutlet weak var challengeTableView: UITableView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var createdChallengeButton: UIButton!
    @IBOutlet weak var completedChallengeButton: UIButton!
    @IBOutlet weak var friendButton: UIButton!
    
    @IBOutlet weak var changeProfileButton: UIButton!
    @IBOutlet weak var addFriendButton: UIButton!
    
    let db = Firestore.firestore()
    
    let currentUser = Auth.auth().currentUser as! User
    
    // Profile id and related profile objects
    internal var userID : String!
    var profile : QueryDocumentSnapshot!
    var friends : [QueryDocumentSnapshot]!
    var currentChallenges = [DocumentReference]()
    
    // Dictionary of tags and cell identifers of list table view
    let cellIdentifers : [Int:String] = [
        0: K.challengeCell, 1: K.challengeCell, 2 : K.friendCell    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        challengeTableView.delegate = self
        challengeTableView.dataSource = self
        
        challengeTableView.register(UINib(nibName: K.myChallengeCellNib, bundle: nil), forCellReuseIdentifier: K.myChallengeCell)
        challengeTableView.rowHeight = 150
        
        createdChallengeButton.tag = 0
        completedChallengeButton.tag = 1
        friendButton.tag = 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadProfile()
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
                let createdChallenges = self.profile[K.profile.created] as! [DocumentReference]
                let completedChallenges = self.profile[K.profile.finished] as! [DocumentReference]
                
                self.currentChallenges = self.profile[K.profile.current] as! [DocumentReference]
                
                self.friends = self.profile[K.profile.friends] as! [QueryDocumentSnapshot]
                
                self.username.text = username
                self.createdChallengeButton.setTitle("\(createdChallenges.count)", for: .normal)
                self.completedChallengeButton.setTitle("\(completedChallenges.count)", for: .normal)
                self.friendButton.setTitle("\(self.friends!.count)", for: .normal)
                
                if let imageURLString = self.profile[K.profile.image] {
                    let imageURL = URL(string: imageURLString as! String)
                    self.profileImageView.af.setImage(withURL: imageURL!)
                    
                    self.hideFeatures()
                }
                self.challengeTableView.reloadData()
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
    
    // Add Friend
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
    
    // Add Profile Image
    @IBAction func addProfileImage(_ sender: Any) {
        performSegue(withIdentifier: K.segue.profileToCamera, sender: sender)
    }
    
    //MARK: - Segue
    @IBAction func toTableView(_ sender: Any) {
        performSegue(withIdentifier: K.segue.profileToTB, sender: sender)
    }
}

// Prepare for segue
extension Profile {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segue.profileToCamera {
            let navigationVC = segue.destination as! UINavigationController
            let vc = navigationVC.topViewController as! CameraViewController
            
            vc.userID = userID
        } else if segue.identifier == K.segue.profileToTB {
            let navigationVC = segue.destination as! UINavigationController
            let vc = navigationVC.topViewController as! ListTableView
            let button = sender as! UIButton
            vc.cellIdentifer = cellIdentifers[button.tag]!
        }
    }
}

// Display tableview of current challenges
extension Profile: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentChallenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.myChallengeCell, for: indexPath) as! MyChallengeCell
        
        // Retrieve the challenge from the challenge reference
        let challengeRef = currentChallenges[indexPath.row]
        challengeRef.getDocument { (document, error) in
            if let e = error {
                print("Error loading current challenges : \(e.localizedDescription)")
            } else if let challenge = document {
                cell.challengeName.text = challenge["Challenge Name"] as! String
                let progressDict = challenge["Progress"] as! [String:Float]
                cell.progressView.progress = progressDict[self.currentUser.email!]!
                cell.timeLeft.text = "0 days"
            }
        }
        return cell
    }
}
