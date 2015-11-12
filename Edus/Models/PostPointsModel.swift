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
    
    var score: Int = 0
    var toPost: Post?
    var voterList = [PFUser]()
    
    func createPoints(){
        let query = PFObject(className: "PostPoints")
        query["score"] = self.score
        query["toPost"] = self.toPost
        query.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("postPoint object saved")
        }
    }
    
    func setPoints(){
        self.score = (self["points"] as? Int)!
        self.toPost = self["toPost"] as? Post
        self.voterList = self["voterList"] as! [PFUser]
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