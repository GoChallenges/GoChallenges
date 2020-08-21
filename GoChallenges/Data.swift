//
//  Data.swift
//  GoChallenges

import Foundation
import Firebase

protocol DocumentSerializsble {
    init?(dictionary:[String:Any])
}

protocol Challenge {
    var creator : String { get }
    var challengeName : String { get }
    var challengeDescription : String { get }
    var goal : Float { get }
    var unit : String { get }
    var start : Date { get }
    var end : Date { get }
    var timeCreated : String { get }
    var category: String { get }
    var participants : Array<String> { get } // Array of emails
    var progress: Dictionary<String, Float> { get } // email:float
    var dictionary: Dictionary<String, Any> {get}
    //var isComplete : Bool {get}
}

struct Data : Challenge {
    
    var creator: String
    var challengeName: String
    var challengeDescription: String
    var goal: Float
    var unit: String
    var start: Date
    var end: Date
    var timeCreated: String
    var category: String
    var participants: Array<String>
    var progress: Dictionary<String, Float>
    
    
    var dictionary : [String:Any]{
        return[
            "Creator" : creator,
            "Challenge Name" : challengeName,
            "Challenge Description" : challengeDescription,
            "Goal" : goal, 
            "Unit" : unit,
            "Start Date" : start,
            "End Date" : end,
            "Time" : timeCreated,
            "Category": category,
            "Participants": participants,
            "Progress": progress
            
        ]
    }
    
    enum CodingKeys: String, CodingKey {
        case creator
        case challengeName
        case challengeDescription
        case goal
        case unit
        case start
        case end
        case timeCreated
        case category
        case participants
        case progress
    }
}

struct Participant {
    var user: User
    var progress: Float
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
