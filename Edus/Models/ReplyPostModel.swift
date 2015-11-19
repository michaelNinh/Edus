//
//  PostModel.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse
import Mixpanel
import Bond

class ReplyPost: PFObject, PFSubclassing{
    
    var content: String?
    var fromUser: PFUser?
    var fromUserName: String?
    
    
    var toPost:Post?
    
    @NSManaged var imageFile: PFFile?
    var replyPostImage: Observable<UIImage?> = Observable(nil)
    
    func uploadReplyPost(){
        let query = PFObject(className: "ReplyPost")
        query["content"] = self.content
        query["fromUser"] = PFUser.currentUser()
        query["fromUserName"] = PFUser.currentUser()?.username!
        //query.ACL?.setPublicWriteAccess(true)

        
        //this line is creating an extra postPoints object
        query["toPost"] = self.toPost
        
        
        //IMAGE CODE
        //if there is an image, upload it
        if self.replyPostImage.value != nil{
            uploadPhoto()
            query["imageFile"] = self.imageFile
        }else{
            print("no image")
        }
        
        query.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("post uploaded")
            let mixpanel: Mixpanel = Mixpanel.sharedInstance()
            mixpanel.track("ReplyPostUploaded")
        }
        
        
    }
    
    func setReplyPost(){
        self.content = self["content"] as? String
        self.fromUser = self["fromUser"] as? PFUser
        self.fromUserName = self["fromUserName"] as? String
        //self.toPostPoints = self["toPostPoints"] as! PostPoints
        self.toPost = self["toPost"] as? Post
        downloadImage()
    }
    
    func downloadImage(){
        if let imgData = self["imageFile"] as? PFFile {
            imgData.getDataInBackgroundWithBlock({
                (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil){
                    let image = UIImage(data: imageData!)
                    self.replyPostImage.value = image
                    print("got image")
                }
            })
        }else{
            print("no photo in file")
        }
    }
    
    
    
    //upload athe photo
    func uploadPhoto() {
        //so...this works but it shouldnt be like this lOL...this is the nil catcher
        if replyPostImage.value == nil{
            //image.value = UIImage(named: "addPhoto")
            print("these is no photo")
        } else{
            //i think this converts the img in Jpeg
            let imageData = UIImageJPEGRepresentation(replyPostImage.value!, 0.8)
            let imageFile = PFFile(data: imageData!)
            //sets the imageFile to be uploaded
            self.imageFile = imageFile
            imageFile?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                print("imageFileSaved")
            })
            
            
        }
    }
    
    
    //start protocol code for PFSubclass
    static func parseClassName() -> String {
        return "ReplyPost"
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    //end
    
    func deleteReplyPost(){
        print(self.objectId!)
        let query = PFQuery(className: "ReplyPost")
        query.getObjectInBackgroundWithId(self.objectId!) { (result: PFObject?, error: NSError?) -> Void in
            if error != nil{
                print(error)
            }else{
                result?.deleteInBackgroundWithBlock({ (succes: Bool, error: NSError?) -> Void in
                    print("replyPost deleted")
                    let deleterPostPoints = ReplyPostPoints()
                    deleterPostPoints.toReplyPost = self
                    deleterPostPoints.deleteReplyPostPoints()
                })
            }
        }
    }
    
}
