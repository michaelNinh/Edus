//
//  MyPostsWriteReplyViewController.swift
//  Edus
//
//  Created by michael ninh on 11/16/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit

class MyPostsWriteReplyPostViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var postQuestionText: UILabel!
    @IBOutlet weak var postContentText: UILabel!
    @IBOutlet weak var replyPostContentText: UITextView!
    
    @IBAction func submitReplyPost(sender: AnyObject) {
        print("what")
        self.replyPost.content = self.replyPostContentText.text
        self.replyPost.toPost = self.post
        self.replyPost.uploadReplyPost()
    }
    
    var post: Post?
    var replyPost = ReplyPost()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.post)
        self.postQuestionText.text = self.post?.title
        self.postContentText.text = self.post?.content
        
        
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