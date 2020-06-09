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
    var joinedDate: Date
    var currentChallenges: [QueryDocumentSnapshot: Float]
    var finishedChallenges: [QueryDocumentSnapshot]
    var friends: [User]
    
    init(username: String, joinedDate: Date, currentChallenges:[QueryDocumentSnapshot: Float], finishedChallenges: [QueryDocumentSnapshot], friends: [User]) {
        self.username = username
        self.joinedDate = joinedDate
        self.currentChallenges = currentChallenges
        self.finishedChallenges = finishedChallenges
        self.friends = friends
        
    }
}
