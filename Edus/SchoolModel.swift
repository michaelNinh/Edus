//
//  SchoolModel.swift
//  Edus
//
//  Created by michael ninh on 11/9/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse

class School: PFObject, PFSubclassing{
    
    var schoolName: String?
    //i am not entirely sure this list of users is even needed
    var enrolledUsers: [PFUser]?
    
    
    //this is async - using "school.save" requires knowledge of throws? must learn
    //creation of an entirely new school, first student
    func createNewSchool(){
        let school = PFObject(className: "School")
        school["schoolName"] = self.schoolName
        //must use currentUserObjId, parse will not take user in array
        school.addObject(PFUser.currentUser()!.objectId!, forKey: "enrolledUsers")
        //set public write access of schoolObjects
        school.ACL?.setPublicWriteAccess(true)
        school.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("School saved.")
        }
        
        let currentUser = PFUser.currentUser()!
        currentUser["activeSchool"] = school
        currentUser["activeSchoolName"] = self.schoolName
        currentUser.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("User assigned school saved.")
        }
        
    }
    
    func enrolledSchool(){
        let school = PFObject(className: "School")
        school.saveInBackground()
    }
    
    func setSchoolName(){
        self.schoolName = self["schoolName"] as? String
    }
    
    
    
    //start protocol code for PFSubclass
    static func parseClassName() -> String {
        return "School"
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
