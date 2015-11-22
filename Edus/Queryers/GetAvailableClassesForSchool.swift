//
//  GetAvailableClassesForSchool.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse

class GetClassForSchool{
    
    static func getClassForSchool(completionBlock: PFQueryArrayResultBlock, range: Range<Int>){
        let query = PFQuery(className: "Classroom")
        query.whereKey("toSchoolName", equalTo: PFUser.currentUser()!["activeSchoolName"]!)
        query.orderByAscending("classTitle")
        query.skip = range.startIndex
        query.limit = range.endIndex - range.startIndex
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
}