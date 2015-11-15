//
//  PostFlagModel.swift
//  Edus
//
//  Created by michael ninh on 11/15/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse


class PostFlag{
    
    var fromUser: PFUser?
    var toPost: Post?
    var toUser: PFUser?
    
    func flagContent(){
        let query = PFObject(className: "FlaggedPost")
        query["fromUser"] = PFUser.currentUser()
        query["toPostId"] = self.toPost
        query["toUser"] = self.toUser
        query.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("post flagged")
        }    }
    
    
}