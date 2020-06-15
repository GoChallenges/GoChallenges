//  NewChallenge.swift
//  GoChallenges

import UIKit
import Firebase

class NewChallenge: UIViewController {
    @IBOutlet weak var challengeNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    
    //let challengeFeed = ChallengesFeed()
    
    let db = Firestore.firestore()
    var challengeArray = [Data]()
    
    let categoryArray = ["Lifestyle", "Food", "Sport", "Game", "Music", "Education", "Finance"]
    var categorySelected : String = ""
    private var message : String = ""
    var goalNum : Float = 0.0
    
    var categoryPickerView  = UIPickerView()
    
    //Picking date variables
    let datePicker = UIDatePicker()
    let currentDate = Date()
    var startDate = Date()
    var endDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        categoryTextField.inputView = categoryPickerView
        categoryTextField.textAlignment = .center
        
        //"Placeholder" for description text view
        descriptionTextView.textColor = .lightGray
        descriptionTextView.text = "Type your description here..."
        descriptionTextView.delegate = self
        
        createDatePicker()
    }
    
    @IBAction func createButton(_ sender: UIButton) {
        if let name = challengeNameTextField.text, let descriptionText = descriptionTextView.text, let userName = Auth.auth().currentUser?.email, let target = goalTextField.text, let firstDay = startTextField.text, let lastDay = endTextField.text, let goalUnit = unitTextField.text{
            
            if name.isEmpty || descriptionText.isEmpty || userName.isEmpty || firstDay.isEmpty || lastDay.isEmpty{
                popUpMessage(text: "At least one of your inputs is empty. Please try again!")
            }
            
            // when the goal value is can be convert into a number
            if let goalNum = Float(target) {
                
                // Get the time the user created the challenge
                //Convert Date to String
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                formatter.dateStyle = .none
                let timeString = formatter.string(from: currentDate)
                
                //Data object
                let newChallenge = Data(creator: userName, challengeName: name, challengeDescription: descriptionText, goal: goalNum, unit: goalUnit,start: startDate, end: endDate,timeCreated: timeString, isComplete: false)
                
                //Add data to database
                var dataRef : DocumentReference? = nil
                
                dataRef = db.collection(categorySelected).addDocument(data: newChallenge.dictionary){
                    error in
                    if let e = error {
                        print("Error adding document to database: \(e.localizedDescription)")
                    }else{
                        print("Document added with ID: \(dataRef!.documentID)")
                    }
                }
            } else {
                popUpMessage(text: "Your input is not a number. Please enter a valid number!")
            }
            
            //move to next screen
            self.performSegue(withIdentifier: K.createToFeed, sender: self)
        }
    }
    
    /*
    //This function will be called by the view controller just before a segue is performed. Use this to pass data to the next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.createToFeed {
            let nav = segue.destination as! UINavigationController //parent screeen
            let feedVC = nav.topViewController as! ChallengesFeed  //child screen
            //feedVC.categoryFilter = categorySelected
            feedVC.startDay = startDate
            feedVC.endDay = endDate
        }
    }
    */
    //this function shows pop up message
    func popUpMessage (text : String){
        let alert = UIAlertController(title: "Error!", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try Again.", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //create the content inside of the date picker view
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
        startTextField.inputAccessoryView = toolbar
        endTextField.inputAccessoryView = toolbar
        
        // set the minimum of the date picker to be the current date
        datePicker.minimumDate = currentDate
        
        startTextField.inputView = datePicker
        endTextField.inputView = datePicker
        
        datePicker.datePickerMode = .date //date style
    }
    
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        if startTextField.isFirstResponder{
            startDate = datePicker.date
            startTextField.text = formatter.string(from: startDate)
        } else {
            endDate = datePicker.date
            endTextField.text = formatter.string(from: endDate)
        }
        
        self.view.endEditing(true) //dismiss the keyboard
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

//MARK: - Description Text View Delegate
extension NewChallenge: UITextViewDelegate{
    //when the user begins edit the text view
    func textViewDidBeginEditing (_ textView : UITextView) {
        if textView.textColor == UIColor.lightGray && textView.isFirstResponder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    //when the user finishes editing the text view
    func textViewDidEndEditing(_ textView : UITextView){
        if textView.text.isEmpty{
            textView.text = "Type your description here..."
            textView.textColor = .lightGray
        }
    }
}
