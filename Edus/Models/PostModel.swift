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
    var points: Int?
    var anonymous: Bool = false
    var voterList: [String] = []
    
    
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
