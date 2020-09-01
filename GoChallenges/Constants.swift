//  Constants.swift
//  GoChallenges

import Foundation

struct K {
    
    // Cell indentifiers
    static let myChallengeCell = "myChallengeCell"
    static let challengeCell = "challengeCell"
    static let friendCell = "friendCell"
    static let profileCell = "profileChallengeCell"
    static let finishedCell = "finishedCell"
    static let createdCell = "createdCell"
    
    // Cell nib names
    static let myChallengeCellNib = "MyChallengeCell"
    static let friendCellNib = "FriendCell"
    static let profileCellNib = "ProfileChallengeCell"
    static let finishedCellNib = "FinishedChallengeCell"
    static let createdCellNib = "CreatedChallengeCell"
    
    // VC nib names
    static let createdChallengesNib = "CreatedChallenges"
    static let finishedChallengesNib = "FinishedChallenges"
    static let friendListNib = "FriendList"
    
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
        
        //view creator button segue
        static let viewCreatorSegue = "detailToProfile"
    }
}
