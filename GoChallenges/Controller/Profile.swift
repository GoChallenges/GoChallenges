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

class Profile: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var joinedDate: UILabel!
    @IBOutlet weak var currentChalLabel: UILabel!
    @IBOutlet weak var completeChalLabel: UILabel!
    @IBOutlet weak var friendsLabel: UILabel!
    
    let user = Auth.auth().currentUser
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUser()
    }
    
    func loadUser() {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
