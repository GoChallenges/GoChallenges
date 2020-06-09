//
//  ProfileData.swift
//  GoChallenges
//
//  Created by nguyen thy on 6/6/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import Foundation
import Firebase

class ProfileData {
    var username: String
    var email: String
    var joinedDate: Date
    var currentChallenges: NSDictionary
    var finishedChallenges: NSDictionary
    var createdChallenges: NSArray
    var friends: [User]
    
    var array: [String:Any] {
        return [
            "email": self.email,
            "name": self.username,
            "joinedDate": self.joinedDate,
            "currentChallenges": self.currentChallenges,
            "finishedChallenges": self.finishedChallenges,
            "createdChallenges": self.createdChallenges,
            "friends": self.friends
        ]
    }
    
    init(username: String, email: String, joinedDate: Date, currentChallenges:NSDictionary, finishedChallenges: NSDictionary, createdChallenges: NSArray, friends: [User]) {
        self.username = username
        self.email = email
        self.joinedDate = joinedDate
        self.currentChallenges = currentChallenges
        self.finishedChallenges = finishedChallenges
        self.createdChallenges = createdChallenges
        self.friends = friends
        
    }
}
