//
//  ReplyPostFlag.swift
//  Edus
//
//  Created by michael ninh on 11/15/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse


class ReplyPostFlag{
    
    var fromUser: PFUser?
    var toReplyPost: ReplyPost?
    var toUser: PFUser?
    
    func flagContent(){
        let query = PFObject(className: "FlaggedReplyPost")
        query["fromUser"] = PFUser.currentUser()
        query["toPostId"] = self.toReplyPost
        query["toUser"] = self.toUser
        query.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("post flagged")
        }    }
    
    
}