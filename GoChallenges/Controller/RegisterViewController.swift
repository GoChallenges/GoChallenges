//  RegisterViewController.swift
//  GoChallenges

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    
    @IBOutlet weak var emailView: UIImageView!
    @IBOutlet weak var passwordView: UIImageView!
    
    @IBOutlet weak var registerButton: UIButton!
    
    let db = Firestore.firestore()
    
    var profileID : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTextfield.delegate = self
        self.emailTextfield.delegate = self
        self.passwordTextfield.delegate = self
        
        updateUI()
        
        nameTextfield.becomeFirstResponder()
       
        
    }
    
    @IBAction func register(_ sender: Any) {
        if let email = emailTextfield.text, let password = passwordTextfield.text, let displayname = nameTextfield.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    self.displayErrorAlert(error: error)
                } else {
    
                    // Create a Profile object
                    var ref: DocumentReference? = nil
                    
                    let profile = ProfileData(displayname: displayname, email: email, joinedDate: Date.init())
                    ref = self.db.collection("Profiles").addDocument(data: profile.dictionary) {
                        err in
                        if let err = err {
                            self.displayErrorAlert(error: err)
                        } else {
                            print("Registered with ID: \(ref!.documentID)")
                            self.profileID = ref!.documentID
                            
                            //perform segue to main feed screen
                            self.performSegue(withIdentifier: K.segue.registerToFeed, sender: self)
                        }
                    }
                }
            }
        }
    }
    
    
    // MARK: - Navigation
}



extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        register(self)
        
        return true
    }
    
}


//MARK: - UI Adjustment

extension RegisterViewController {
    func updateUI() {
        emailView.layer.cornerRadius = 20
        passwordView.layer.cornerRadius = 20
        registerButton.layer.cornerRadius = 10
    }
}

