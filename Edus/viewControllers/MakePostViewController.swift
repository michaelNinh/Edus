//
//  MakePostViewController.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import Parse

class MakePostViewController: UIViewController, UITextFieldDelegate {
    
    var classroom: Classroom?
    //create a post Object
    var post = Post()

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
    
    @IBAction func submitPostButton(sender: AnyObject) {
        self.post.title = self.titleText.text
        self.post.content = self.contentText.text
        self.post.toClassroom = self.classroom
        self.post.subject = self.classroom?.subject
        self.post.subjectLevel = self.classroom?.subjectLevel
        self.post.fromUser = PFUser.currentUser()
        
        self.post.uploadPost()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        anonymousToggleButton.on = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
