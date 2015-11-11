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
    var toSchool: School?
    //these would come in introductory, intermediate, advance, levels. would require users to know which classification is needed!
    var subjectLevel: String?
    var subject: String?
    var enrolledUsers: [PFUser]?
    
    func enrollClass(){
        let classroom = PFObject(className: "Classroom")
        classroom["professor"] = self.professorLastName
        classroom["classTitle"] = self.classTitle
        classroom["subject"] = self.subject
        
        let currentUser = PFUser.currentUser()!
        //create a query for class _User
        //query where key "User" == currentUser
        //query.includekey "activeSchool"
        let activeSchool = PFUser.currentUser()!["activeSchool"]!.fetchIfNeededInBackground() as! School
        
        classroom["toSchool"] = PFUser.currentUser()!["activeSchool"] as! School
        
        classroom.addObject(PFUser.currentUser()!.objectId!, forKey: "enrolledUsers")
        classroom.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("added student to class.")
        }
        
        PFUser.currentUser()!.addObject(classroom, forKey: "enrolledClasses")
        PFUser.currentUser()!.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("added class to student.")
        }
    }
    
    
    
    func setClass(){
        self.professorLastName = self["professorLastName"] as? String
        self.classTitle = self["classTitle"] as? String
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
