//
//  RegisterViewController.swift
//  GoChallenges
//
//  Created by nguyen thy on 6/1/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextfield.delegate = self
        self.passwordTextfield.delegate = self
        
        emailTextfield.becomeFirstResponder()
    }
    
    @IBAction func register(_ sender: Any) {
        if let email = emailTextfield.text, let password = passwordTextfield.text, let name = nameTextfield.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    self.displayErrorAlert(error: error)
                } else {
                    // Update display name
                    let currentUser = Auth.auth().currentUser
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = name
                    changeRequest?.commitChanges { (error) in
                        if let error = error {
                            self.displayErrorAlert(error: error)
                        }
                    }
                    
                    
                    // Create a Profile object
                    var ref: DocumentReference? = nil
                    let profile = ProfileData(username: name, email: email, joinedDate: Date.init(), currentChallenges: [:], finishedChallenges: [:], createdChallenges: [],
                                              friends: [])
                    
                    ref = self.db.collection("Profiles").addDocument(data: profile.array) {
                        err in
                        if let err = err {
                            self.displayErrorAlert(error: err)
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                            
                            //perform segue to main feed screen
                            self.performSegue(withIdentifier: K.registerToFeed, sender: self)
                        }
                    }
                }
            }
        }
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



extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        register(self)
        
        return true
    }
}
