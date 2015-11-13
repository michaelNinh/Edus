//
//  PostModel.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse

class Post: PFObject, PFSubclassing{
    
    var title: String?
    var content: String?
    var fromUser: PFUser?
    var fromUserName: String?
    var anonymous: Bool = false
    
    //create a postPoint Object
    var toPostPoints = PostPoints()
    var toClassroom:Classroom?
    var subject:String?
    var subjectLevel:String?
    
    func uploadPost(){
        let query = PFObject(className: "Post")
        query["title"] = self.title
        query["content"] = self.content
        query["anonymous"] = self.anonymous
        query["fromUser"] = self.fromUser
        query["fromUserName"] = PFUser.currentUser()?.username!
        query["subject"] = self.subject
        query["subjectLevel"] = self.subjectLevel
        query["toClassroom"] = self.toClassroom
        
        
        //THIS CREATES A POSTPOINT OBJECT
        query["toPostPoints"] = self.toPostPoints
        
        query.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("post uploaded")
            self.toPostPoints.createPoints()
        }
        
        
    }
    
    func setPost(){
        self.title = self["title"] as? String
        self.content = self["content"] as? String
        self.fromUser = self["fromUser"] as? PFUser
        self.fromUserName = self["fromUserName"] as? String
        self.anonymous = (self["anonymous"] as? Bool)!
        //self.toPostPoints = self["toPostPoints"] as! PostPoints
        self.toClassroom = self["toClassroom"] as? Classroom
        self.subject = self["subject"] as? String
        self.subjectLevel = self["subjectLevel"] as? String
        self.toPostPoints = self["toPostPoints"] as! PostPoints
        self.toPostPoints.setPoints()
        //no need to set points? data is already there???
        //self.toPostPoints.setPoints()

    }
    
    
    //start protocol code for PFSubclass
    static func parseClassName() -> String {
        return "Post"
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
