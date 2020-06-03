//  Data.swift
//  GoChallenges

import Foundation
import RealmSwift

// This represents the Realm Data
class Data: Object {
    //@objc dynamic helps Realm monitors these variables while the app is running
    @objc dynamic var challengeName : String = ""
    @objc dynamic var challengeDescription: String = ""
    @objc dynamic var userName : String = ""
    @objc dynamic var isComplete : Bool = false
    @objc dynamic var creator: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var createdData : Date!
}
