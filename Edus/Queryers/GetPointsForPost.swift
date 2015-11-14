//
//  GetPointsForPost.swift
//  Edus
//
//  Created by michael ninh on 11/14/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse


class GetPointsForPost{
    
    static func getPointsForPost(completionBlock: PFQueryArrayResultBlock, post:Post) {
        let query = PFQuery(className: "PostPoints")
        query.whereKey("toPost", equalTo: post)
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
}