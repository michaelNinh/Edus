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
    
    //THIS IS FOR CREATING A NEW CLASS
    func enrollClass(){
        let classroom = PFObject(className: "Classroom")
    
        classroom["subject"] = self.subject
        classroom["subjectLevel"] = self.subjectLevel
        classroom["toSchoolName"] = PFUser.currentUser()!["activeSchoolName"] as! String
        classroom["classTitle"] = self.classTitle
        classroom["professorLastName"] = self.professorLastName
        
        //in order for this to work, need to figure out how to pull relational data from PfUser...
        //let activeSchool = PFUser.currentUser()!["activeSchool"]! as! School
        //classroom["toSchool"] = PFUser.currentUser()!["activeSchool"] as! School
        
        classroom.addObject(PFUser.currentUser()!.objectId!, forKey: "enrolledUsers")
        classroom.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("added student to class.")
        }
        
        PFUser.currentUser()!.addObject(classroom, forKey: "enrolledClasses")
        PFUser.currentUser()!.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("added class to student.")
        }
    }
    
    //THIS IS ADDING STUDENT INTO EXISTING CLASS
    func addIntoClass(){
        //query into classname "Classroom"
        let addQuery = PFQuery(className: "Classroom")
        //get classroom with matching objId to self (the target)
        addQuery.getObjectInBackgroundWithId(self.objectId!) { (result: PFObject?, error: NSError?) -> Void in
            if error != nil{
                print("damn son thur an error")
                //if the result can be assigned as a classroom
            }else if let classroom = result{
                //add user Id into classroom's enrolled users
                classroom.addObject(PFUser.currentUser()!.objectId!, forKey: "enrolledUsers")
                classroom.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                    print("added student to class.")
                    
                    //add classroom Id into User's enrolled
                    PFUser.currentUser()!.addObject(classroom, forKey: "enrolledClasses")
                    PFUser.currentUser()!.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                        print("added class to student.")
                    }
                    
                }
                
            }
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
