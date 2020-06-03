//
//  MyChallenges.swift
//  GoChallenges
//
//  Created by nguyen thy on 6/1/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit

class MyChallenges: UIViewController, UITableViewDataSource {
    
    class Challenge {
        var name: String
        var description: String
        var progress: Float
        init(name: String, description: String, progress: Float) {
            self.name = name
            self.description = description
            self.progress = progress
        }
    }

    let challenges =
        [Challenge(name: "Water", description: "2L", progress: 0.56),
         Challenge(name: "WO", description: "30 min", progress: 0.9),
         Challenge(name: "Dance", description: "1 hour", progress: 0.25)
    ]

    @IBOutlet weak var challengesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        challengesTableView.delegate = self
        challengesTableView.dataSource = self
        
        challengesTableView.register(UINib(nibName: K.myChallengeCellNib, bundle: nil), forCellReuseIdentifier: K.myChallengeCell)
        challengesTableView.rowHeight = 150
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
        
        cell.challengeName.text = challenge.name
        cell.challengeDes.text = challenge.description
        cell.progressView.progress = challenge.progress
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.currentToDetail, sender: self)
    }
}
