//
//  GetUserEnrolledClasses.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse

class GetUserEnrolledClasses {
    
    
    static func getUserEnrolledClasses(completionBlock: PFQueryArrayResultBlock){
        
        let enrolledQuery = PFQuery(className: "_User")
        enrolledQuery.includeKey("enrolledClasses")
        enrolledQuery.getObjectInBackgroundWithId(PFUser.currentUser()!.objectId!)
            

        
}

}



/*

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

*/
