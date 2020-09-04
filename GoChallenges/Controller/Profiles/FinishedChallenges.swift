//
//  FinishedChallenges.swift
//  GoChallenges
//
//  Created by nguyen thy on 8/31/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit
import Firebase

class FinishedChallenges: UIViewController, UITableViewDelegate {
    @IBOutlet weak var challengesTableView: UITableView!
    
    let db = Firestore.firestore()
    
    var challenges = [DocumentReference]()
    var profileID = "0" // String ID of current profile
    
    override func viewDidLoad() {
        super.viewDidLoad()

        challengesTableView.delegate = self
        challengesTableView.dataSource = self
        
        challengesTableView.register(UINib(nibName: K.finishedCellNib, bundle: nil), forCellReuseIdentifier: K.finishedCell)
        challengesTableView.rowHeight = 150
        loadChallenges()
    }

    // Query this profile to get finishedChallenges array
    func loadChallenges() {
        let profileRef = db.collection("Profiles").document(profileID)
        profileRef.getDocument { (documentSnapshots, error) in
            if let data = documentSnapshots?.data() {
                self.challenges = data[K.profile.created] as! [DocumentReference]
                self.challengesTableView.reloadData()
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

extension FinishedChallenges: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = challengesTableView.dequeueReusableCell(withIdentifier: K.finishedCell, for: indexPath) as! FinishedChallengeCell
        let challengeRef = challenges[indexPath.row]
        challengeRef.getDocument { (documentSnapshots, error) in
            if let challenge = documentSnapshots {
                let name = challenge["Challenge Name"] as! String
                let goal = challenge["Goal"] as! NSNumber
                let unit = challenge["Unit"] as! String
                
                // Get max time to complete
                let calendar = Calendar.current
                let startDate = (challenge["Start Date"] as! Timestamp).dateValue()
                let endDate = (challenge["End Date"] as! Timestamp).dateValue()
                let components = calendar.dateComponents([.day], from: startDate, to: endDate)
                
                cell.nameLabel.text = name
                cell.goalLabel.text = "\(goal) \(unit)"
                cell.timeLabel.text = "\(components.day!) days"
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
        return cell
    }
    
}
