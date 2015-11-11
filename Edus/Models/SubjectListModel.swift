//
//  SubjectListModel.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse


class SubjectList: PFObject, PFSubclassing {
    
    var subjectName: String?
    
    func setSubjectName(){
        self.subjectName = self["subjectName"] as? String
    }
 
    //start protocol code for PFSubclass
    static func parseClassName() -> String {
        return "SubjectList"
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