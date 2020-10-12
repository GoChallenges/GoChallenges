//  ChallengeDetail.swift
//  GoChallenges

import UIKit
import Firebase
class ChallengeDetail: UIViewController {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    //Custom toolbar for the keyboard of the textfield
    @IBOutlet weak var currentProgress: UITextField!{
        didSet {currentProgress?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonForCurrentProgressTextField)))}
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var remaingLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    
    let db = Firestore.firestore()
    var creatorEmail : String! // Email (string) of the creator of this challenge
    
    //Data got from last screen
    var descriptionText: String = ""
    var nameText : String = ""
    var startDate : String = ""
    var endDate : String = ""
    var daysLeft : String = ""
    var goal : Double = 0.0
    var unit : String = ""
    var docID : String = ""
    
    var current :  Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        //Display datas
        nameLabel.text = nameText
        descriptionTextView.text = descriptionText
        startLabel.text = startDate
        endLabel.text = endDate
        remaingLabel.text = daysLeft
        
        currentProgress.delegate = self
        currentProgress.keyboardType = UIKeyboardType.decimalPad
        
        if daysLeft == "The challenge is expired"{
            currentProgress.isUserInteractionEnabled = false
        }
        
    }
    
    //View creator button
    @IBAction func creatorButton(_ sender: Any) {
        performSegue(withIdentifier: K.segue.viewCreatorSegue, sender: self)
    }
    
    //Send data to the next vc
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! Profile // The destination vc as Profile
        vc.email = creatorEmail
        print(self.creatorEmail) // Send the creator email to Profile VC
    }
    
    //If touch outside, the keyboard will hide
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentProgress.resignFirstResponder()
    }
    
    //Done button action for the current progress textfield
    @objc func doneButtonForCurrentProgressTextField(){
        if let currentStr = currentProgress.text {
            if let current = Double(currentStr){
                //Calculate the progress
                let remainVal = goal - current
                goal = remainVal //Updated goal
                progressLabel.text = "You need \(String(remainVal)) \(unit) to complete this challenge."
                
                //Update the "Goal" field in that specific document
                let updateRef = db.collection("Challenges").document(docID)
                updateRef.updateData([
                    "Goal": goal
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
                
            }
        }
        currentProgress.resignFirstResponder()
    }
}

//MARK: - Current Progress Text Field Delegate
extension ChallengeDetail: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //This makes the textfield currently has the focus to release its focus and the keyboard will hide.
        currentProgress.resignFirstResponder()
        return true
    }
}

//MARK: - Done toolbar button for keyboard of textfield
extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }

    // Default actions:
    @objc func doneButtonTapped() {
        self.resignFirstResponder()
    }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
    
    
}
