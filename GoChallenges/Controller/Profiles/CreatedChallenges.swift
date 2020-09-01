//
//  CreatedChallenges.swift
//  GoChallenges
//
//  Created by nguyen thy on 8/31/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit
import Firebase

class CreatedChallenges: UIViewController, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    var profileID = "0"
    var challenges = [DocumentReference]() // Array of created challenges
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.createdCellNib, bundle: nil), forCellReuseIdentifier: K.createdCell)
        tableView.rowHeight = 100
        
        loadChallenges()
    }
    
    // Query this profile to get createdChallenges array
    func loadChallenges() {
        let profileRef = db.collection("Profiles").document(profileID)
        profileRef.getDocument { (documentSnapshots, error) in
            if let data = documentSnapshots?.data() {
                self.challenges = data[K.profile.created] as! [DocumentReference]
                self.tableView.reloadData()
            } else {
                let error = error
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
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

//MARK: - Load TableView data
extension CreatedChallenges: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.createdCell, for: indexPath)
        let challengeRef = challenges[indexPath.row]
        challengeRef.getDocument { (documentSnapshots, error) in
            if let challenge = documentSnapshots {
                let name = challenge["Challenge Name"] as! String
                let description = challenge["Challenge Description"] as! String
                let number = (challenge["Participants"] as! NSArray).count
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
        return cell
    }
}


