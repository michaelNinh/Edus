//
//  UserModel.swift
//  Edus
//
//  Created by michael ninh on 11/9/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse

class User: PFObject, PFSubclassing{
    
    var activeSchool: School?
    //for adding classes, would append the classroom object into this list
    var enrolledClasses: [Classroom]?
    
    
    func enrollSchool(){
        let query = PFObject(className: "_User")
        query["activeSchool"] = self.activeSchool
        query.saveInBackground()
        print("school made active")
    }
    
    func enrollClasses(){
        let query = PFObject(className: "_User")
        query["enrolledClasses"] = self.enrolledClasses
    }
    
    //this pulls data from parse and inserts into app
    func setUserData(){
        self.activeSchool = self["activeSchool"] as? School
        self.enrolledClasses = self["enrolledClasses"] as? [Classroom]
    }
    
    
    
    //start protocol code for PFSubclass
    static func parseClassName() -> String {
        return "User"
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    //end
}


