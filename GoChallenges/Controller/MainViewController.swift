//
//  MainViewController.swift
//  GoChallenges
//
//  Created by nguyen thy on 6/1/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit
import Firebase


class MainViewController: UIViewController {

    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signinButton.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 10
    }
    

    @IBAction func toSignin(_ sender: Any) {
        performSegue(withIdentifier: K.segue.toSignin, sender: sender)
    }
    
    @IBAction func toRegister(_ sender: Any) {
        performSegue(withIdentifier: K.segue.toRegister, sender: sender)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
