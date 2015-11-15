//
//  PostModel.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse

class ReplyPost: PFObject, PFSubclassing{
    
    var content: String?
    var fromUser: PFUser?
    var fromUserName: String?
    
    
    var toPost:Post?
    
    
    func uploadReplyPost(){
        let query = PFObject(className: "ReplyPost")
        query["content"] = self.content
        query["fromUser"] = PFUser.currentUser()
        query["fromUserName"] = PFUser.currentUser()?.username!
        //query.ACL?.setPublicWriteAccess(true)

        
        //this line is creating an extra postPoints object
        query["toPost"] = self.toPost
        
        
        //THIS CREATES A POSTPOINT OBJECT
        
        query.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("post uploaded")
        }
        
        
    }
    
    func setReplyPost(){
        self.content = self["content"] as? String
        self.fromUser = self["fromUser"] as? PFUser
        self.fromUserName = self["fromUserName"] as? String
        //self.toPostPoints = self["toPostPoints"] as! PostPoints
        self.toPost = self["toPost"] as? Post
        
    }
    
    
    //start protocol code for PFSubclass
    static func parseClassName() -> String {
        return "ReplyPost"
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    //end
    
    func deleteReplyPost(){
        print(self.objectId!)
        let query = PFQuery(className: "ReplyPost")
        query.getObjectInBackgroundWithId(self.objectId!) { (result: PFObject?, error: NSError?) -> Void in
            if error != nil{
                print(error)
            }else{
                result?.deleteInBackgroundWithBlock({ (succes: Bool, error: NSError?) -> Void in
                    print("replyPost deleted")
                    let deleterPostPoints = ReplyPostPoints()
                    deleterPostPoints.toReplyPost = self
                    deleterPostPoints.deleteReplyPostPoints()
                })
            }
        }
    }
    
}
