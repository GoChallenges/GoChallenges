//
//  MyChallenges.swift
//  GoChallenges
//
//  Created by nguyen thy on 6/1/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit
import Firebase

class MyChallenges: UIViewController, UITableViewDataSource {
    
    let db = Firestore.firestore()
    var challenges = [QueryDocumentSnapshot]()
    
    let categoryArray = ["Lifestyle", "Food", "Sport", "Game", "Music", "Education", "Finance"]

    @IBOutlet weak var challengesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        challengesTableView.delegate = self
        challengesTableView.dataSource = self
        
        challengesTableView.register(UINib(nibName: K.myChallengeCellNib, bundle: nil), forCellReuseIdentifier: K.myChallengeCell)
        challengesTableView.rowHeight = 150
        
        loadChallenges()
    }
    
    func loadChallenges() {
        let challengesRef  = db.collection("Food")
        let query = challengesRef.whereField("Completion", isEqualTo: false)
        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                for doc in querySnapshot!.documents {
                    print(doc.data())
                }
                self.challenges = querySnapshot!.documents
                self.challengesTableView.reloadData()
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

extension MyChallenges: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myChallengeCell", for: indexPath) as! MyChallengeCell
        let challenge = challenges[indexPath.row]
        
        cell.challengeName.text = challenge["Challenge Name"] as! String
        cell.challengeDes.text = challenge["Challenge Description"] as! String
        cell.progressView.progress = 0.4
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.currentToDetail, sender: self)
    }
}
