//
//  Constants.swift
//  GoChallenges
//
//  Created by nguyen thy on 6/1/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import Foundation

struct K {
    
    // Segue identifiers
    static let toRegister = "toRegister"
    static let toSignin = "toSignin"
    
    
    static let signinToFeed = "signinToFeed"
    static let registerToFeed = "registerToFeed"
    
    static let feedToDetail = "feedToDetail"
    static let createToFeed = "createToFeed"
    static let currentToDetail = "currentToDetail"
    static let profileToFriendList = "profileToFriendList"
    
    // Cell indentifiers
    static let myChallengeCell = "myChallengeCell"
    static let challengeCell = "challengeCell"
    // Cell nib names
    static let myChallengeCellNib = "MyChallengeCell"
    
    // Collection names
    static let profiles = "Profiles"
    
    // Collection keys
    struct profile {
        static let email = "email"
        static let name = "name"
        static let date = "joinedDate"
        static let current = "currentChallenges"
        static let finished = "finishedChallenges"
        static let friends = "friends"
    }
}
