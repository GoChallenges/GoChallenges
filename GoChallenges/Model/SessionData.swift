//
//  SessionData.swift
//  GoChallenges
//
//  Created by nguyen thy on 8/20/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import Foundation
import Firebase

/* Create when successfully loggin/ register
Used to stored data that will be required and used across the app
 */
class SessionData {
    static let sharedInstance =  SessionData()
    var currentUser: User! // Loggin user
    var profileID: String! // ID of the user's Profile
}

var sessionData = SessionData()
