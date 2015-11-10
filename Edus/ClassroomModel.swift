//
//  ClassroomModel.swift
//  Edus
//
//  Created by michael ninh on 11/9/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse

class Classroom: PFObject, PFSubclassing{
    
    var professorLastName: String?
    var classTitle: String?
    var toUser: PFUser?
    var toSchool: School?
    //these would come in introductory, intermediate, advance, levels. would require users to know which classification is needed!
    var subjectLevel: String?
    
    func enrollClass(){
        let classroom = PFObject(className: "Classroom")
        classroom["professor"] = self.professorLastName
        classroom["toUser"] = PFUser.currentUser()
        classroom["classTitle"] = self.classTitle
        classroom["toSchool"] = PFUser.currentUser()!["activeSchool"] as? String
        classroom.saveInBackground()
        print("enrolled class")
    }
    
    
    
    func setClass(){
        self.professorLastName = self["professorLastName"] as? String
        self.classTitle = self["classTitle"] as? String
        self.toUser = PFUser.currentUser()
        self.toSchool = self["toSchool"] as? School
    }
    
    func deleteClass(classObjectId: String){
        let query = PFQuery(className: "Classroom")
        query.getObjectInBackgroundWithId(classObjectId){
            (result: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let result = result {
                result.deleteInBackground()
                result.saveInBackground()
                print("deleted")
            }
        }
    }
    
    
    //start protocol code for PFSubclass
    static func parseClassName() -> String {
        return "Classroom"
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
