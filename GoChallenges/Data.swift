//
//  Data.swift
//  GoChallenges

import Foundation



struct Data{
    var creator : String
    var challengeName : String
    var challengeDescription : String
    var goal : Float
    var unit : String
    var start : Date
    var end : Date
    var timeStamp : Date
    var isComplete : Bool = false
    
    var dictionary : [String:Any]{
        return[
            "Creator" : creator,
            "Challenge Name" : challengeName,
            "Challenge Description" : challengeDescription,
            "Goal" : goal,
            "Unit" : unit,
            "Start Date" : start,
            "End Date" : end,
            "timeStamp" : timeStamp,
            "Completion" : isComplete
        ]
    }
}
