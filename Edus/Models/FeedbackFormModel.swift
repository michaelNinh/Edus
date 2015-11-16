//
//  FeedbackFormModel.swift
//  Edus
//
//  Created by michael ninh on 11/16/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse


class FeedbackModel: PFObject, PFSubclassing{
    
    var fromUser: String?
    var message: String?
    
    func uploadFeedback(){
        let query = PFObject(className: "Feedback")
        query["message"] = self.message
        query["fromUser"] = PFUser.currentUser()!
        query.saveInBackground()
        
    }

    
    //start protocol code for PFSubclass
    static func parseClassName() -> String {
        return "Feedback"
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
}