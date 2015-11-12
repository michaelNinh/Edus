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
    var points: Int = 0
    var anonymous: Bool = false
    var voterList: [String] = []
    
    var toClass:Classroom?
    var subject:String?
    var subjectLevel:String?
    
    func uploadPost(){
        let query = PFObject(className: "Post")
        query["title"] = self.title
        query["content"] = self.content
        query["points"] = self.points
        query["anonymous"] = self.anonymous
        query["voterList"] = self.voterList
        query["fromUser"] = self.fromUser
        query["subject"] = self.subject
        query["subjectLevel"] = self.subjectLevel
        
        query.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("post uploaded")
        }
        

        
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
