//
//  Data.swift
//  GoChallenges

import Foundation



struct Data{
    var creator : String
    var challengeName : String
    var challengeDescription : String
    var timeStamp : Date
    var isComplete : Bool = false
    
    var dictionary : [String:Any]{
        return[
            "Creator" : creator,
            "Challenge Name" : challengeName,
            "Challenge Description" : challengeDescription,
            "timeStamp" : timeStamp,
            "Completion" : isComplete
        ]
    }
}
