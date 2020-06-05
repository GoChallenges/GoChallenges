//  ChallengesFeed.swift
//  GoChallenges

import UIKit
import Firebase

class ChallengesFeed: UIViewController {

    @IBOutlet weak var challengeTableView: UITableView!

    
    let db = Firestore.firestore()
    
    var categoryFilter : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //challengeTableView.dataSource = self
        //challengeTableView.delegate = self
        checkForUpdates()
        
    }
    
    func loadData(){
        //db.collection(newChallenge.categorySelected)
    }
    
    func checkForUpdates(){
 
    }


}
/*
//MARK: - Table View Data Source
extension  ChallengesFeed : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }

}

//MARK: - Table View Delegate
extension ChallengesFeed : UITableViewDelegate{
    
}
*/
