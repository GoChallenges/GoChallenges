//
//  ProfileData.swift
//  GoChallenges
//
//  Created by nguyen thy on 6/6/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import Foundation
import Firebase

protocol UserProfile {
    var displayname: String {get}
    var email: String {get}
    var joinedDate: Date {get}
    var currentChallenges: Array<DocumentReference> {get}
    var finishedChallenges: Array<DocumentReference> {get}
    var createdChallenges: Array<DocumentReference> {get}
    var friends: Array<QueryDocumentSnapshot> {get}
}

class ProfileData : UserProfile{
    var displayname: String
    
    var email: String
    
    var joinedDate: Date
    
    var currentChallenges: Array<DocumentReference>
    
    var finishedChallenges: Array<DocumentReference>
    
    var createdChallenges: Array<DocumentReference>
    
    var friends: Array<QueryDocumentSnapshot>
    
        
    var dictionary: [String:Any] {
        return [
            "email": self.email,
            "name": self.displayname,
            "joinedDate": self.joinedDate,
            "currentChallenges": self.currentChallenges,
            "finishedChallenges": self.finishedChallenges,
            "createdChallenges": self.createdChallenges,
            "friends": self.friends
        ]
    }
    
    init(displayname: String, email: String, joinedDate: Date) {
        self.displayname = displayname
        self.email = email
        self.joinedDate = joinedDate
        
//        self.currentChallenges = [QueryDocumentSnapshot]()
//        self.finishedChallenges = [QueryDocumentSnapshot]()
//        self.createdChallenges = [QueryDocumentSnapshot]()
        
        self.currentChallenges = [DocumentReference]()
        self.finishedChallenges = [DocumentReference]()
        self.createdChallenges = [DocumentReference]()
        
        self.friends = [QueryDocumentSnapshot]()
        
    }
}
