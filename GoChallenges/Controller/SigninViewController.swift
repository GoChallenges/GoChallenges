//  SigninViewController.swift
//  GoChallenges

import UIKit
import Firebase

class SigninViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailView: UIImageView!
    @IBOutlet weak var passwordView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    @IBOutlet var heightConstraint : NSLayoutConstraint!
       
       // The code to change the height constraint of the logo image when in landscape mode
      override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval){
           if toInterfaceOrientation == .landscapeLeft || toInterfaceOrientation == .landscapeRight{
               // Imageview height constraint outlate
               heightConstraint.constant = 0
            
           }
           else{
               heightConstraint.constant = 232
               
           }
       }
    /*
    func addLeftImage(txtField: UITextField, img: UIImage){
        let leftImageView = UIImageView()
        leftImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }
    */
    @IBAction func signIn(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error{
                    //pop up error message
                    let alert = UIAlertController(title: "Error!", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Try Again.", style: UIAlertAction.Style.default, handler: { (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self!.present(alert, animated: true, completion: nil)
                }else{
                    print("Log In successful")
                    
                    //perform segue here
                    self?.performSegue(withIdentifier: K.segue.signinToFeed, sender: self)
                    
                }
            }
        }
    }

}

//MARK: - UI Adjustment

extension SigninViewController {
    func updateUI() {
        emailTextField.layer.cornerRadius = 10
        passwordTextField.layer.cornerRadius = 10
        emailTextField.layer.masksToBounds = true
        passwordTextField.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 13
        emailView.layer.cornerRadius = 20
        passwordView.layer.cornerRadius = 20
    }
}
