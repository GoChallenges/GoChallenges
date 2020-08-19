//  ChallengeDetail.swift
//  GoChallenges

import UIKit
import Firebase
class ChallengeDetail: UIViewController {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var remaingLabel: UILabel!
    
    let db = Firestore.firestore()
    
    //Data got from last screen
    var descriptionText: String = ""
    var nameText : String = ""
    var startDate : String = ""
    var endDate : String = ""
    var daysLeft : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Display datas
        nameLabel.text = nameText
        descriptionTextView.text = descriptionText
        startLabel.text = startDate
        endLabel.text = endDate
        remaingLabel.text = daysLeft
    }
    
    //View creator button
    @IBAction func creatorButton(_ sender: Any) {
        performSegue(withIdentifier: K.segue.viewCreatorSegue, sender: self)
    }
}
