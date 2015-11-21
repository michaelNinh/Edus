//
//  AvailableSchoolListQuery.swift
//  Edus
//
//  Created by michael ninh on 11/10/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse

class GetAvailableSchools{
    
    //MUST MAKE SURE VIEW GETS UPDATED
    
    static func getAvailableSchools(completionBlock: PFQueryArrayResultBlock, range: Range<Int>){
        let query = PFQuery(className: "School")
        query.orderByAscending("schoolName")
        query.skip = range.startIndex
        query.limit = range.endIndex - range.startIndex
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
}