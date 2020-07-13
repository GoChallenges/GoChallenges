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
    
    @IBOutlet weak var changeProfileButton: UIButton!
    
    internal var userID : String!
    
    let currentUser = Auth.auth().currentUser
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadProfile()
    }
    
    // Load the current user profile
    private func loadProfile() {
        let profileRef = db.collection(K.profiles)
        let email = currentUser?.email
        let query = profileRef.whereField("email", isEqualTo: email!)
        
        query.getDocuments { (querySnapshots, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                let profile = querySnapshots!.documents[0]
                
                self.userID = profile.documentID
                
                let username = profile[K.profile.name] as! String
                let currentChallenges = profile[K.profile.current] as! NSDictionary
                let completeChallenges = profile[K.profile.finished] as! NSDictionary
                let friends = profile[K.profile.friends] as! NSArray
                
                self.username.text = username
                self.currentChalLabel.text = "\(currentChallenges.count)"
                self.completeChalLabel.text = "\(completeChallenges.count)"
                self.friendsLabel.text = "\(friends.count)"
                
                if let imageURLString = profile[K.profile.image] {
                    let imageURL = URL(string: imageURLString as! String)
                    self.profileImageView.af.setImage(withURL: imageURL!)
                }
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.profileToCamera {
            let navigationVC = segue.destination as! UINavigationController
            let vc = navigationVC.topViewController as! CameraViewController
            
            vc.userID = userID
        }
    }
    
    
    //MARK: - Add Profile Image

    @IBAction func addProfileImage(_ sender: Any) {
        performSegue(withIdentifier: K.profileToCamera, sender: sender)
    }
}

