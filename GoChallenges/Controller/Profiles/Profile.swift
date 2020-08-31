//  Profile.swift
//  GoChallenges

import UIKit
import Firebase
import FirebaseAuth
import AlamofireImage

/*
 Receives the EMAIL of the previous vc and uses it to load the wanted profile
 */
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
    let currentUser = Auth.auth().currentUser!
    
    // Profile id and related profile objects
    // Initialized all variable to belong to current user and change by previous vc if needed
    
    var profileID = String() // Id of the wanted profile
    var email = String() // Email of wanted profile
    var profile : QueryDocumentSnapshot! // The wanted profile either current user (from tab bar vc) or creator (challenge vc)
    var friends : [QueryDocumentSnapshot]!
    var currentChallenges = [DocumentReference]() // An array of challenges currently in, not finished, has DocumentReference to each of them
    
    // Dictionary of button tags and according cell identifers for ListTableView (vc)
    let cellIdentifers : [Int:String] = [
        0: K.createdCell, 1: K.finishedCell, 2 : K.friendCell]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        challengeTableView.delegate = self
        challengeTableView.dataSource = self
        
        // Register challenge tb cell nib
        challengeTableView.register(UINib(nibName: K.profileCellNib, bundle: nil), forCellReuseIdentifier: K.profileCell)
        challengeTableView.rowHeight = 150
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2 // Radius of profile image
        
        // Assign tags to each button
        createdChallengeButton.tag = 0
        completedChallengeButton.tag = 1
        friendButton.tag = 2
        
        // No data passed to this vc, meaning it came from the tab bar vc
        if email == "" {
            sessionData.currentUser = currentUser
            email = sessionData.currentUser.email!
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // Load the intended profile using an email
        loadProfile()
    }
    
    // Load the current user profile
    private func loadProfile() {
        let profileRef = db.collection(K.profiles)
        let query = profileRef.whereField("email", isEqualTo: email)
        
        query.getDocuments { (querySnapshots, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                self.profile = querySnapshots!.documents[0]
                
                self.profileID = self.profile.documentID
                
                let username = self.profile[K.profile.name] as! String
                let createdChallenges = self.profile[K.profile.created] as! [DocumentReference]
                let completedChallenges = self.profile[K.profile.finished] as! [DocumentReference]
                
                self.currentChallenges = self.profile[K.profile.current] as! [DocumentReference]
                
                self.friends = self.profile[K.profile.friends] as! [QueryDocumentSnapshot]
                
                self.username.text = username
                self.createdChallengeButton.setTitle("\(createdChallenges.count)", for: .normal)
                self.completedChallengeButton.setTitle("\(completedChallenges.count)", for: .normal)
                self.friendButton.setTitle("\(self.friends!.count)", for: .normal)
                
                // Display profile image if there is one saved in the Profile
                if let imageURLString = self.profile[K.profile.image] {
                    let imageURL = URL(string: imageURLString as! String)
                    self.profileImageView.af.setImage(withURL: imageURL!)
                    
                    self.hideFeatures()
                }
                
                // Reload tableview
                self.challengeTableView.reloadData()
            }
        }
    }
        
    // Add Friend
    @IBAction func addFriend(_ sender: Any) {
        addFriend()
    }
    
    // Add Profile Image
    @IBAction func addProfileImage(_ sender: Any) {
        performSegue(withIdentifier: K.segue.profileToCamera, sender: sender)
    }
    
    //MARK: - Segues
    @IBAction func toCreatedChallenges(_ sender: Any) {
        let vc = CreatedChallenges(nibName: K.createdChallengesNib, bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func toFinishedChallenges(_ sender: Any) {
    }
    
    @IBAction func toFriends(_ sender: Any) {
    }
    
}

// Display tableview of current challenges
extension Profile: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentChallenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.profileCell, for: indexPath) as! ProfileChallengeCell
        
        // Retrieve the challenge from the challenge reference
        
        let challengeRef = currentChallenges[indexPath.row]
        challengeRef.getDocument { (document, error) in
            if let e = error {
                print("Error loading current challenges : \(e.localizedDescription)")
            } else if let challenge = document {
                let progress = challenge["Progress"] as! NSDictionary
                let progressNumber = progress[self.email] as! NSNumber
                let progressDouble = Double(progressNumber)
                
                cell.challengeLabel.text = (challenge["Challenge Name"] as! String)
                cell.circleProgressView.progress = progressDouble
            }
        }
        return cell
    }
}

// Function for the functionalities of the vc
extension Profile {
    
    // Hide the Add friend and Add Profile Image Features
    func hideFeatures() {
        
        // Not current user's profile
        if email != currentUser.email! {
            
            // Hide change profile picture button and show add friend button
            changeProfileButton.isHidden = true
            addFriendButton.isHidden = false
            
            // Check if added friend
            if self.friends.isEmpty != false {
                addFriendButton.isHidden = friends.contains(profile) ? true : false
            } else {
                addFriendButton.isHidden = false
            }
            
        } else { // Current user's profile
            changeProfileButton.isHidden = false
            addFriendButton.isHidden = true
        }
    }
    
    // Add friend the current profile
    func addFriend() {
        
        // Update the Friends array of this Profile object and that array of current Profile
        let db = Firestore.firestore()
        let thisProfileRef = db.collection("Profiles").document(self.profileID) // Reference to this profile
        let myProfileRef = db.collection("Profiles").document(sessionData.profileID) // Reference to current user profile
        
        // Add current user's profile ref to this profile friends array
        thisProfileRef.updateData([K.profile.friends: FieldValue.arrayUnion([myProfileRef])]) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Added friend")
            }
        }

        // Add this user's profile id to current user friends array
        myProfileRef.updateData([K.profile.friends: FieldValue.arrayUnion([thisProfileRef])]) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Added friend")
            }
        }
    }
    
    // Prepare for segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Going to CameraViewController (vc)
        if segue.identifier == K.segue.profileToCamera {
            let navigationVC = segue.destination as! UINavigationController
            let vc = navigationVC.topViewController as! CameraViewController
            
            // Send the userID of current user
            vc.profileID = profileID
            
        // Going to ListTableView (vc)
        //} else if segue.identifier == K.segue.profileToTB {
//            let navigationVC = segue.destination as! UINavigationController
//            let vc = navigationVC.topViewController as! ListTableView
//            let button = sender as! UIButton
//
//            // Send the appropriate cell indentifers depending on button pushed
//            vc.cellIdentifer = cellIdentifers[button.tag]!
//
//            vc.myProfileID = profileID // Send the profile being used id
        }
    }
}

