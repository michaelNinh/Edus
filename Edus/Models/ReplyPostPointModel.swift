//
//  PostPointsModel.swift
//  Edus
//
//  Created by michael ninh on 11/12/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse

class ReplyPostPoints: PFObject, PFSubclassing{
    
    var score: Int = 1
    //var toPost: Post?
    var voterList = [String]()
    
    func createReplyPoints(){
        
        let query = PFQuery(className: "ReplyPostPoints")
        query.getObjectInBackgroundWithId(self.objectId!) { (result: PFObject?, error: NSError?) -> Void in
            let replyPostPoint = result as! ReplyPostPoints
            replyPostPoint["score"] = self.score
            replyPostPoint["voterList"] = self.voterList
            replyPostPoint.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                print("replyPostPoint object saved")
            }
        }
    }
    
    func upVote(){
        
        let query = PFQuery(className: "ReplyPostPoints")
        //crashes due to nil here
        query.getObjectInBackgroundWithId(self.objectId!) { (result: PFObject?, error: NSError?) -> Void in
            let replyPostPoints = result as! ReplyPostPoints
            self.score = self["score"] as! Int
            //or postPoints["score"] as! Int ???
            self.score += 1
            replyPostPoints["score"] = self.score
            replyPostPoints.addObject(PFUser.currentUser()!.objectId!, forKey: "voterList")
            replyPostPoints.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                print("replyPostPoint upvoted")
            }
        }
        
    }
    
    func checkVoterList() -> Bool{
        if self.voterList.contains(PFUser.currentUser()!.objectId!){
            return true
        }else{
            return false
        }
    }
    
    
    func setReplyPoints(){
        self.score = self["score"] as! Int
        //self.toPost = self["toPost"] as? Post
        self.voterList = self["voterList"] as! [String]
    }
    
    //func incrementpoints
    
    //funcAddVoters
    
    //start protocol code for PFSubclass
    static func parseClassName() -> String {
        return "ReplyPostPoints"
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