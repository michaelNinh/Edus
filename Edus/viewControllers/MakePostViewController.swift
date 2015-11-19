//
//  MakePostViewController.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import Parse

class MakePostViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var classroom: Classroom?
    //create a post Object
    var post = Post()
    var photoTakingHelper: PhotoTakingHelper?

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var contentText: UITextView!
    
    @IBOutlet weak var anonymousToggleButton: UISwitch!
    @IBAction func anonymousToggle(sender: AnyObject) {
        
        if anonymousToggleButton.on{
            self.post.anonymous = true
        } else{
            self.post.anonymous = false
        }
        
    }
    
    @IBAction func addImage(sender: AnyObject) {
        takePhoto()
    }
    
    @IBAction func submitPostButton(sender: AnyObject) {
        self.post.title = self.titleText.text
        
        if self.contentText.text == "What do you want to ask?"{
            self.post.content = ""
        }else{
            self.post.content = self.contentText.text
        }
        
        
        self.post.toClassroom = self.classroom
        self.post.subject = self.classroom?.subject
        self.post.subjectLevel = self.classroom?.subjectLevel
        self.post.fromUser = PFUser.currentUser()
        
        self.post.uploadPost()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentText.delegate = self
        self.contentText.text = "What do you want to ask?"
        self.contentText.textColor = UIColor.lightGrayColor()
        
        anonymousToggleButton.on = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //take Photo function
    func takePhoto() {
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
            self.post.postImage.value = image
            //self.photoPlaceHolder.image = image
            self.addImageToTextView()
        }
    }
    
    //add image preview to textView
    func addImageToTextView(){
        let image = self.post.postImage.value
        let imgAttachment = NSTextAttachment()
        imgAttachment.image = image
        let attString = NSAttributedString(attachment: imgAttachment)
        self.contentText.textStorage.insertAttributedString(attString, atIndex: 0)
    }
    
    
    //MUST EVENTUALLY FIX TEXT PLACEHOLDER COLOR AND DELETION
    //text placeHolderstuff
    func textViewDidBeginEditing(textView: UITextView) {
        
        /*
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
*/
        if textView.text.containsString("What do you want to ask?") {
            textView.textColor = UIColor.blackColor()
        }
    
    }
    
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What do you want to ask?"
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    //MARK: Close keyboard
    
    /**
    * Called when 'return' key pressed. return NO to ignore.
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        self.view.endEditing(true)
    }
    
}
