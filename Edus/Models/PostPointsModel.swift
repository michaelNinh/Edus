//
//  PostPointsModel.swift
//  Edus
//
//  Created by michael ninh on 11/12/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse

class PostPoints: PFObject, PFSubclassing{
    
    var score: Int = 1
    //var toPost: Post?
    var voterList = [String]()
    
    func createPoints(){
        
        let query = PFQuery(className: "PostPoints")
        query.getObjectInBackgroundWithId(self.objectId!) { (result: PFObject?, error: NSError?) -> Void in
            let postPoint = result as! PostPoints
            //postPoint["toPost"] = self.toPost
            postPoint["score"] = self.score
            postPoint["voterList"] = self.voterList
            postPoint.ACL?.setPublicWriteAccess(true)
            postPoint.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                print("postPoint object saved")
            }
        }
    }
    
    func upVote(){
        
        let query = PFQuery(className: "PostPoints")
        //crashes due to nil here
        query.getObjectInBackgroundWithId(self.objectId!) { (result: PFObject?, error: NSError?) -> Void in
            let postPoint = result as! PostPoints
            self.score = self["score"] as! Int
            //or postPoints["score"] as! Int ???
            self.score += 1
            postPoint["score"] = self.score
            postPoint.addObject(PFUser.currentUser()!.objectId!, forKey: "voterList")
            postPoint.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                print("postPoint upvoted")
            }
        }
        
    }
    
    /*
    func checkVoterList(completionBlock: ((inList: Bool) -> Void))  {
        let query = PFQuery(className: "PostPoints")
        query.getObjectInBackgroundWithId(self.objectId!) { (result: PFObject?, error: NSError?) -> Void in
            //let postPoint = result as! PostPoints
            self.voterList = self["voterList"] as! [String]
            if self.voterList.contains(PFUser.currentUser()!.objectId!){
                //already voted
                completionBlock(inList : true)
            }else{
                //did not vote
                completionBlock(inList: false)
            }
        }
    }
*/
  
    func checkVoterList() -> Bool{
        if self.voterList.contains(PFUser.currentUser()!.objectId!){
            return true
        }else{
            return false
        }
    }
    
    
    func setPoints(){
        self.score = self["score"] as! Int
        //self.toPost = self["toPost"] as? Post
        self.voterList = self["voterList"] as! [String]
        self.objectId = self["objectId"] as? String
    }
    
    //func incrementpoints
    
    //funcAddVoters
    
    //start protocol code for PFSubclass
    static func parseClassName() -> String {
        return "PostPoints"
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