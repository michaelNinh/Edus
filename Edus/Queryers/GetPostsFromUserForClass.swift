//
//  GetPostsFromUserForClass.swift
//  Edus
//
//  Created by michael ninh on 11/15/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse

class GetPostsFromUserForClass{
    
    static func getPostsForClass(completionBlock: PFQueryArrayResultBlock, classroom: Classroom, range: Range<Int>){
        
        /*
        let sameClassQuery = PFQuery(className: "Post")
        //this is where I would modify to create different post category results
        sameClassQuery.whereKey("toClassroom", equalTo: classroom)
*/
        
        
        let sameUserQuery = PFQuery(className: "Post")
        sameUserQuery.whereKey("fromUser", equalTo: PFUser.currentUser()!)
        sameUserQuery.whereKey("toClassroom", equalTo: classroom)
        
        
        let postQuery = PFQuery.orQueryWithSubqueries([sameUserQuery])
        postQuery.includeKey("toPostPoints")
        postQuery.orderByDescending("createdAt")
        postQuery.skip = range.startIndex
        postQuery.limit = range.endIndex - range.startIndex
        postQuery.findObjectsInBackgroundWithBlock(completionBlock)
        
    }
    
}