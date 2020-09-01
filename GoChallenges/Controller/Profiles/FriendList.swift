//
//  FriendList.swift
//  GoChallenges
//
//  Created by nguyen thy on 8/31/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit
import Firebase
class FriendList: UIViewController {
    @IBOutlet weak var friendTableView: UITableView!
    
    var friends = [DocumentReference]()

    override func viewDidLoad() {
        super.viewDidLoad()

        friendTableView.delegate = self
        friendTableView.dataSource = self
        friendTableView.register(UINib(nibName: K.friendCellNib, bundle: nil), forCellReuseIdentifier: K.friendCell)
        friendTableView.rowHeight = 100
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

extension FriendList: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return friends.count
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendTableView.dequeueReusableCell(withIdentifier: K.friendCell, for: indexPath)
        return cell
    }
    
    
}
