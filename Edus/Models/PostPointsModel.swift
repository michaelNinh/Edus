//
//  PostPointsModel.swift
//  Edus
//
//  Created by michael ninh on 11/12/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse
import Mixpanel

class PostPoints: PFObject, PFSubclassing{
    
    var score: Int = 2
    var voterList = [String]()
    var toPost: Post?
    
    
    func upVote(){
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("post upvoted")
        
        let postPointQuery = PFQuery(className: "PostPoints")
        postPointQuery.whereKey("toPost", equalTo: self.toPost!)
        postPointQuery.findObjectsInBackgroundWithBlock { (result: [PFObject]?, error: NSError?) -> Void in
            //get results and insert into this list
            let resultList = result as! [PostPoints]
            
            //if the list is empty, means no point object exists so we create one
            if resultList == []{
                let query = PFObject(className: "PostPoints")
                query["toPost"] = self.toPost
                query["score"] = self.score
                query.addObject(PFUser.currentUser()!.objectId!, forKey: "voterList")
                query.ACL?.setPublicWriteAccess(true)
                query.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                    print("postPoint created and saved")
                }
                //if list is populated, points already exists so we update it
            }else{
                let targetPointObject = resultList[0] as PostPoints
                self.score = targetPointObject["score"] as! Int
                self.score += 1
                targetPointObject["score"] = self.score
                targetPointObject.addObject(PFUser.currentUser()!.objectId!, forKey: "voterList")
                targetPointObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                    print("postPoint upvoted")
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
    
    
    func setPoints(){
        self.score = self["score"] as! Int
        self.voterList = self["voterList"] as! [String]
    }
    
    func deletePostPoints(){
        let query = PFQuery(className: "PostPoints")
        query.whereKey("toPost", equalTo: self.toPost!)
        query.findObjectsInBackgroundWithBlock { (result: [PFObject]?, error: NSError?) -> Void in
            if error != nil{
                print(error)
            }else{
                let targetPointObj = result![0] as? PostPoints
                targetPointObj?.deleteInBackgroundWithBlock({ (succcess: Bool, error: NSError?) -> Void in
                    print("associated postPoints deleted")
                })
            }
        }
    }
    
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

/*

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

func upVote(){
let postPointQuery = PFQuery(className: "PostPoints")
postPointQuery.whereKey("toPost", equalTo: self.toPost!)
postPointQuery.findObjectsInBackgroundWithBlock { (result: [PFObject]?, error: NSError?) -> Void in
//get results and insert into this list
let resultList = result as! [PostPoints]

//if the list is empty, means no point object exists so we create one
if resultList == []{
let query = PFObject(className: "PostPoints")
query["toPost"] = self.toPost
query["score"] = self.score
query.addObject(PFUser.currentUser()!.objectId!, forKey: "voterList")
query.ACL?.setPublicWriteAccess(true)
query.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
print("postPoint created and saved")
}
//if list is populated, points already exists so we update it
}else{
let targetPointObject = resultList[0] as PostPoints
self.score = targetPointObject["score"] as! Int
self.score += 1
targetPointObject["score"] = self.score
targetPointObject.addObject(PFUser.currentUser()!.objectId!, forKey: "voterList")
targetPointObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
print("postPoint upvoted")
}


}


}
}

*/