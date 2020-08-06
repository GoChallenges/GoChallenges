//
//  ListTableView.swift
//  GoChallenges
//
//  Created by nguyen thy on 8/2/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit
import Firebase

class ListTableView: UIViewController, UITableViewDelegate{
    
    let segueDict = [K.friendCell : K.segue.TBToProfile,
                     K.challengeCell: K.segue.TBToChallengeDetail
    ]
    
    var cellIdentifer : String!

    var segueIdentifer : String {
        return segueDict[cellIdentifer]!
    }
    
    var challenges = [DocumentReference]()
    var friends = [DocumentReference]()
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: K.friendCellNib, bundle: nil), forCellReuseIdentifier: cellIdentifer)
        listTableView.rowHeight = 80
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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

extension ListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellIdentifer == K.friendCell {
            return 4
        } else {
            return challenges.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! FriendCell
        return cell
    }
}
