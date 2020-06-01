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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func toSignin(_ sender: Any) {
        performSegue(withIdentifier: K.toSignin, sender: sender)
    }
    
    @IBAction func toRegister(_ sender: Any) {
        performSegue(withIdentifier: K.toRegister, sender: sender)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
