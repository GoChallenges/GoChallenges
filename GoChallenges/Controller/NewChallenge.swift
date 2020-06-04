//  NewChallenge.swift
//  GoChallenges

import UIKit
import Firebase

class NewChallenge: UIViewController {
    @IBOutlet weak var challengeNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    
    let db = Firestore.firestore()
    var challengeArray = [Data]()
    
    private let categoryArray = ["Lifestyle", "Food", "Sport", "Game", "Music", "Education", "Finance"]
    private var message : String = ""
    private var categorySelected : String = ""
    private var goalNum : Float?
    var categoryPickerView  = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        categoryTextField.inputView = categoryPickerView
        categoryTextField.textAlignment = .center
    }
    
    @IBAction func createButton(_ sender: UIButton) {
        if let name = challengeNameTextField.text, let description = descriptionTextView.text, let userName = Auth.auth().currentUser?.email, let target = goalTextField.text{
            
            if name.isEmpty || description.isEmpty || userName.isEmpty || target.isEmpty{
                message = "At least one of your inputs is empty. Please try again."
                popUpMessage(text: message)
            }
            
            
            if let goalNum = Float(target){
                let newChallenge = Data(creator: userName, challengeName: name, challengeDescription: description, goal: goalNum, timeStamp: Date(), isComplete: false)
                
                var dataRef : DocumentReference? = nil
                
                dataRef = db.collection(categorySelected).addDocument(data: newChallenge.dictionary){
                    error in
                    if let e = error {
                        print("Error adding document to database: \(e.localizedDescription)")
                    }else{
                        print("Document added with ID: \(dataRef!.documentID)")
                    }
                }
            } else{
                //Pop up warning
                message = "Your goal is not a number! Please try again."
                popUpMessage(text: message)
            }
            
        }
    }
    
    func popUpMessage(text : String){
        let alert = UIAlertController(title: "Error!", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    

}

//MARK: - Category Picker View Data Source
extension NewChallenge: UIPickerViewDataSource{
    //returns how many individual segments there are in the picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //returns the number of rows in the segment
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArray.count
    }
}

//MARK: - Category Picker View Delegate
extension NewChallenge: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categorySelected = categoryArray[row]
        categoryTextField.text = categoryArray[row]
        categoryTextField.resignFirstResponder()
        
    }

}
