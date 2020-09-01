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
    
    var challenges = [DocumentReference]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        challengesTableView.delegate = self
        challengesTableView.dataSource = self
        
        challengesTableView.register(UINib(nibName: K.finishedCellNib, bundle: nil), forCellReuseIdentifier: K.finishedCell)
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

extension FinishedChallenges: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return challenges.count
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = challengesTableView.dequeueReusableCell(withIdentifier: K.finishedCell, for: indexPath)
        return cell
    }
    
}
