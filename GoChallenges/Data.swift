//
//  Data.swift
//  GoChallenges

import Foundation



struct Data{
    var creator : String
    var challengeName : String
    var challengeDescription : String
    var goal : Float
    var timeStamp : Date
    var isComplete : Bool = false
    
    var dictionary : [String:Any]{
        return[
            "Creator" : creator,
            "Challenge Name" : challengeName,
            "Challenge Description" : challengeDescription,
            "Goal" : goal,
            "timeStamp" : timeStamp,
            "Completion" : isComplete
        ]
    }
}
