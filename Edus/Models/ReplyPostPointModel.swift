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
    
    var score: Int = 2
    var voterList = [String]()
    var toReplyPost: ReplyPost?
    
    func upVote(){
        let postPointQuery = PFQuery(className: "ReplyPostPoints")
        postPointQuery.whereKey("toReplyPost", equalTo: self.toReplyPost!)
        postPointQuery.findObjectsInBackgroundWithBlock { (result: [PFObject]?, error: NSError?) -> Void in
            //get results and insert into this list
            let resultList = result as! [ReplyPostPoints]
            
            //if the list is empty, means no point object exists so we create one
            if resultList == []{
                let query = PFObject(className: "ReplyPostPoints")
                query["toPost"] = self.toReplyPost
                query["score"] = self.score
                query.addObject(PFUser.currentUser()!.objectId!, forKey: "voterList")
                query.ACL?.setPublicWriteAccess(true)
                query.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                    print("replyPostPoint created and saved")
                }
                //if list is populated, points already exists so we update it
            }else{
                
                let targetPointObject = resultList[0] as ReplyPostPoints
                self.score = targetPointObject["score"] as! Int
                self.score += 1
                targetPointObject["score"] = self.score
                targetPointObject.addObject(PFUser.currentUser()!.objectId!, forKey: "voterList")
                targetPointObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                    print("replyPostPoint upvoted")
                }
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
    
    func deleteReplyPostPoints(){
        let query = PFQuery(className: "ReplyPostPoints")
        query.whereKey("toReplyPost", equalTo: self.toReplyPost!)
        query.findObjectsInBackgroundWithBlock { (result: [PFObject]?, error: NSError?) -> Void in
            if error != nil{
                print(error)
            }else{
                let targetPointObj = result![0] as? ReplyPostPoints
                targetPointObj?.deleteInBackgroundWithBlock({ (succcess: Bool, error: NSError?) -> Void in
                    print("associated replyPostPoints deleted")
                })
            }
        }
    }
    
    
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