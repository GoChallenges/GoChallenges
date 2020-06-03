//  NewChallenge.swift
//  GoChallenges

import UIKit
import Firebase

class NewChallenge: UIViewController {
    @IBOutlet weak var challengeNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryTextField: UITextField!
    
    let db = Firestore.firestore()
    var challengeArray = [Data]()
    
    private let categoryArray = ["Lifestyle", "Food", "Sport", "Game", "Music", "Education", "Finance"]
    private var categorySelected : String = ""
    var categoryPickerView  = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        categoryTextField.inputView = categoryPickerView
        categoryTextField.textAlignment = .center
    }
    
    @IBAction func createButton(_ sender: UIButton) {
        if let name = challengeNameTextField.text, let description = descriptionTextView.text, let userName = Auth.auth().currentUser?.email{
            let newChallenge = Data(creator: userName, challengeName: name, challengeDescription: description, timeStamp: Date(), isComplete: false)
            
            var dataRef : DocumentReference? = nil
            
            dataRef = db.collection(categorySelected).addDocument(data: newChallenge.dictionary){
                error in
                if let e = error {
                    print("Error adding document to database: \(e.localizedDescription)")
                }else{
                    print("Document added with ID: \(dataRef!.documentID)")
                }
            }
        }
    
        
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
