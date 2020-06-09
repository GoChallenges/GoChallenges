//
//  GeneralFunctions.swift
//  GoChallenges
//
//  Created by nguyen thy on 6/9/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func displayErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
