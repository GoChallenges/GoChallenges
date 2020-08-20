//
//  MyChallenges.swift
//  GoChallenges
//
//  Created by nguyen thy on 6/1/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit
import Firebase

class MyChallenges: UIViewController, UITableViewDataSource {
    
    let db = Firestore.firestore()
    var challenges = [QueryDocumentSnapshot]()
    let currentUser = Auth.auth().currentUser as! User
    
    //variables to pass to the next view controller file
    var passDescrip : String = "" //description
    var passName : String = "" //name
    
    //Variables to turn Firestore Timestamp to Date
    var startTimestamp = Timestamp()
    var endTimestamp = Timestamp()
    
    //Date variables
    var startDay = Date()
    var endDay = Date()
    var currentDay = Date()
    var remainingDays : String = ""
    
    //let categoryArray = ["Lifestyle", "Food", "Sport", "Game", "Music", "Education", "Finance"]

    @IBOutlet weak var challengesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        challengesTableView.delegate = self
        challengesTableView.dataSource = self
        
        challengesTableView.register(UINib(nibName: K.myChallengeCellNib, bundle: nil), forCellReuseIdentifier: K.myChallengeCell)
        challengesTableView.rowHeight = 150
        
        loadChallenges()
    }
    
    func loadChallenges() {
        let challengesRef  = db.collection("Challenges")
        let fp = FieldPath(["Lifestyle"])
        let query = challengesRef.whereField("Category", isEqualTo: "Food")
        
        
        challengesRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                for doc in querySnapshot!.documents {
                    print(doc.data())
                }
                self.challenges = querySnapshot!.documents
                self.challengesTableView.reloadData()
            }
        }
    }
        
}

//MARK: - DEQUEUE CELLS AND QUERY ATTENDED CHALLENGES

extension MyChallenges: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myChallengeCell", for: indexPath) as! MyChallengeCell
        let challenge = challenges[indexPath.row]
        
        cell.challengeName.text = challenge["Challenge Name"] as! String
        
        let time = challenge["End Date"] as! Timestamp
        let endDate = time.dateValue()
        
        let now = Date.init()
        
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: now)
        let date2 = calendar.startOfDay(for: endDate)
        
        let components = calendar.dateComponents([.day, .hour, .second], from: date1, to: date2)
        let daysLeft = components.day!
        let hoursLeft = components.hour!
        let secsLeft = components.second!
        
        if daysLeft < 1 {
            if hoursLeft < 1 {
                cell.timeLeft.text = "\(secsLeft) sec(s) left"
            } else {
                cell.timeLeft.text = "\(hoursLeft) hour(s) left"
            }
        } else {
            cell.timeLeft.text = "\(daysLeft) day(s) left"
        }
        
        let progress = challenge["Progress"] as! NSDictionary
        let email = currentUser.email as! String
        let progressNumber = progress[email] as! NSNumber
        let progressFloat = Float(progressNumber)
        cell.progressView.progress = progressFloat
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Pass Data from the table view cell to the challenge details screen
        
        let challenge = challenges[indexPath.row]
        passDescrip = challenge["Challenge Description"] as! String
        passName = challenge["Challenge Name"] as! String
        
        //Convert Firestore Timestamp to Date or NSDate
        startTimestamp = challenge["Start Date"] as! Timestamp
        startDay = startTimestamp.dateValue()
        endTimestamp = challenge["End Date"] as! Timestamp
        endDay = endTimestamp.dateValue() //turn to Date
        
        //if statement to get the remaining days to complete the challenge
        if currentDay > startDay && currentDay < endDay{
            remainingDays = String(Calendar.current.dateComponents([.day], from: currentDay, to: endDay).day!)

        }else if currentDay <= startDay{
            remainingDays = String(Calendar.current.dateComponents([.day], from: startDay, to: endDay).day!)
        }else if currentDay == endDay{
            remainingDays = "0"
        }else if currentDay > endDay{
            remainingDays = "The challenge is expired"
        }
        // need to check when current day is greater than the endDay in the future
        
        //Transfer the challenge's data to the next view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "detailView") as! ChallengeDetail
        detailVC.descriptionText = passDescrip
        detailVC.nameText = passName
        
        //Convert Date to String for start and end dates
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        detailVC.startDate = formatter.string(from: startDay)
        detailVC.endDate = formatter.string(from: endDay)
        detailVC.daysLeft = remainingDays
        
        //Send the creator email to challenge detail screen
        let creatorEmail = challenge["Creator"] as! String // Email (string) of the selected challenge
        detailVC.creatorEmail = creatorEmail 
        
        //Move to the challenge detail screen
        self.present(detailVC, animated: true, completion: nil)
        //stop highlight the cell after select
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
