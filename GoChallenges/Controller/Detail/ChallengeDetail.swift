//
//  ChallengeDetail.swift
//  GoChallenges
//
//  Created by nguyen thy on 6/1/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit
import Firebase
class ChallengeDetail: UIViewController {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var remaingLabel: UILabel!
    
    let db = Firestore.firestore()
    //var challengeDict = [QueryDocumentSnapshot]()
    
    //Data got from last screen
    var descriptionText: String = ""
    var nameText : String = ""
    var startDate : String = ""
    var endDate : String = ""
    var daysLeft : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = nameText
        descriptionTextView.text = descriptionText
        startLabel.text = startDate
        endLabel.text = endDate
        remaingLabel.text = daysLeft
    }
    /*
    func loadData(){
        db.collection("Food").getDocuments { (querySnapshot, error) in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                self.challengeDict = querySnapshot!.documents
                descriptionTextView.text = challengeDict.chall
            }
        }
    }
 */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
