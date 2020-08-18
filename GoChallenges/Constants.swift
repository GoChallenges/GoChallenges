//
//  Constants.swift
//  GoChallenges
//
//  Created by nguyen thy on 6/1/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import Foundation

struct K {
    
    // Cell indentifiers
    static let myChallengeCell = "myChallengeCell"
    static let challengeCell = "challengeCell"
    static let friendCell = "friendCell"
    static let profileCell = "profileChallengeCell"
    
    // Cell nib names
    static let myChallengeCellNib = "MyChallengeCell"
    static let friendCellNib = "FriendCell"
    static let profileCellNib = "ProfileChallengeCell"
    
    // Collection names
    static let profiles = "Profiles"
    
    // Collection keys
    struct profile {
        static let email = "email"
        static let name = "name"
        static let date = "joinedDate"
        static let current = "currentChallenges"
        static let finished = "finishedChallenges"
        static let created = "createdChallenges"
        static let friends = "friends"
        static let image = "profileImageURL"
    }
    
    struct segue {
        static let toRegister = "toRegister"
        static let toSignin = "toSignin"
        
        
        static let signinToFeed = "signinToFeed"
        static let registerToFeed = "registerToFeed"
        
        static let feedToDetail = "feedToDetail"
        static let createToFeed = "createToFeed"
        static let currentToDetail = "currentToDetail"
        static let profileToFriendList = "profileToFriendList"
        static let profileToCamera = "profileToCamera"
        
        static let cameraToProfile = "cameraToProfile"
        
        static let profileToTB = "profileToTableView"
        
        static let TBToProfile = "tableViewToProfile"
        static let TBToChallengeDetail = "tableViewToChallengeDetail"
    }
}
