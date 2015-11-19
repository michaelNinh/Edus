//
//  PhotoTakingHelper.swift
//  Edus
//
//  Created by michael ninh on 11/19/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import Parse

//any function that wants to be the callback of the PhotoTakingHelper needs to have exactly this signature.
typealias PhotoTakingHelperCallback = UIImage? -> Void


class PhotoTakingHelper: NSObject {
    
    /** View controller on which AlertViewController and UIImagePickerController are presented */
     //below variable was initial named "viewController" changing it to "AddPostController" since that is the controller that alerts will be presented on
     //i changed it back to viewController to make it easier -> these are local variables anyways
    
    weak var viewController: UIViewController!
    var callback: PhotoTakingHelperCallback
    var imagePickerController: UIImagePickerController?
    
    init(viewController: UIViewController, callback: PhotoTakingHelperCallback) {
        self.viewController = viewController
        self.callback = callback
        
        super.init()
        
        showPhotoSourceSelection()
        //somewhere in here there should be a function that takes the photo and displays it as the button picture and removes the button text
        //happens after selecting a photo
    }
    
    func showPhotoSourceSelection() {
        // Allow user to choose between photo library and camera
        let alertController = UIAlertController(title: nil, message: "Where do you want to get your picture from?", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Only show camera option if rear camera is available
        if (UIImagePickerController.isCameraDeviceAvailable(.Rear)) {
            let cameraAction = UIAlertAction(title: "Photo from Camera", style: .Default) { (action) in
                self.showImagePickerController(.Camera)
            }
            
            alertController.addAction(cameraAction)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo from Library", style: .Default) { (action) in
            self.showImagePickerController(.PhotoLibrary)
        }
        
        alertController.addAction(photoLibraryAction)
        
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //this function creates the UIImagePicker...SourceType on the variable "ImagePickerController" variable declared above
    func showImagePickerController(sourceType: UIImagePickerControllerSourceType) {
        imagePickerController = UIImagePickerController()
        imagePickerController!.sourceType = sourceType
        //this required the extension to fit the protocol (ref. A)
        imagePickerController!.delegate = self
        
        
        self.viewController.presentViewController(imagePickerController!, animated: true, completion: nil)
    }
    
}

//This is REF. A -> the protocol
extension PhotoTakingHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        viewController.dismissViewControllerAnimated(false, completion: nil)
        //the below sets the image to be shot back to AddPostController (the image that is called back)
        callback(image)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
