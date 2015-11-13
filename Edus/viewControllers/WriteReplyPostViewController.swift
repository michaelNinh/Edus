//
//  WriteReplyPostViewController.swift
//  Edus
//
//  Created by michael ninh on 11/13/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit

class WriteReplyPostViewController: UIViewController {
    
    
    @IBOutlet weak var postQuestionText: UILabel!
    @IBOutlet weak var postContentText: UILabel!
    @IBOutlet weak var replyPostContentText: UITextView!
    
    @IBAction func uploadReplyPost(sender: AnyObject) {
        
        self.replyPost.content = self.replyPostContentText.text
        self.replyPost.toPost = self.post
        self.replyPost.uploadReplyPost()
        
    }
    
    var post: Post?
    var replyPost = ReplyPost()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
