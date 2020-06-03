//  NewChallenge.swift
//  GoChallenges

import UIKit
import RealmSwift

class NewChallenge: UIViewController {
    @IBOutlet weak var challengeNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func createButton(_ sender: UIButton) {
        print(Realm.Configuration.defaultConfiguration.fileURL) //realm file destination
        
        let realm = try! Realm()
        var challengeData = Data()
        if let name = challengeNameTextField.text, let description = descriptionTextView.text{
            challengeData.challengeName = name
            challengeData.challengeDescription = description
        }
        
        do{
            try realm.write{
                realm.add(challengeData)
            }
        } catch{
            print("Cannot save data.")
        }
        
        
        
    }
    

}
