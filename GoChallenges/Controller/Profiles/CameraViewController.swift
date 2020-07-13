//
//  CameraViewController.swift
//  GoChallenges
//
//  Created by nguyen thy on 6/11/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit
import Firebase

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var pickedImageView: UIImageView!
    
    var userID: String!
    var imageURLString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Pick an Image and Display to VC

    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func onLibraryButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the image captured by the UIImagePickerController
        let editedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        pickedImageView.image = editedImage
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    //MARK: - Upload the image file to Firebase Storage
    @IBAction func completeProfile(_ sender: Any) {
        let imageName = NSUUID().uuidString
        
        let storage = Storage.storage()
        let storageRef = storage.reference().child("profile_image.png").child("\(imageName).png")
        
        if let updateData = pickedImageView.image!.pngData() {
            storageRef.putData(updateData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                } else {
                    print("Upload profile successfully")
                    
                    // Update profile image url in Database
                    
                    // Get the URL String
                    storageRef.downloadURL { (url, error) in
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        } else {
                            self.imageURLString = url?.absoluteString
                            print(self.imageURLString)
                            
                            // Update Profiles object wit URL String
                            let db = Firestore.firestore()
                            let profileRef = db.collection("Profiles").document(self.userID)
                            profileRef.updateData(["profileImageURL" : self.imageURLString]) { (error) in
                                if let error = error {
                                    print("Error: \(error)")
                                } else {
                                    print("Add image url to database successfully")
                                    self.dismiss(animated: true, completion: nil)
                                }
                            }
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
