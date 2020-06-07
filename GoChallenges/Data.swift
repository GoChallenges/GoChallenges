//
//  Data.swift
//  GoChallenges

import Foundation
import Firebase

protocol DocumentSerializsble {
    init?(dictionary:[String:Any])
}

struct Data{
    var creator : String
    var challengeName : String
    var challengeDescription : String
    var goal : Float
    var unit : String
    var start : Date
    var end : Date
    var timeCreated : String
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
            "time" : timeCreated,
            "Completion" : isComplete
        ]
    }
}
/*
extension Data : DocumentSerializsble{
    init?(dictionary: [String:Any]){
        guard let creator = dictionary["Creator"] as? String,
            let challengeName = dictionary["Challenge Name"] as? String,
            let challengeDescription = dictionary["Challenge Description"] as? String,
            let goal = dictionary["Goal"] as? Float,
            let unit = dictionary["Unit"] as? String,
            let start = dictionary["Start Date"] as? Date,
            let end = dictionary["End Date"] as? Date,
            let timeStamp = dictionary["timeStamp"] as? Date,
            let isComplete = dictionary["Completion"] as? Bool else {return nil}
        self.init(creator: creator, challengeName: challengeName, challengeDescription: challengeDescription, goal: goal, unit: unit, start: start, end: end, timeStamp: timeStamp, isComplete: isComplete)
    }
}
*/
