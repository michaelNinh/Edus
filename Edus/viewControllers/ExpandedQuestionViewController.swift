//
//  ExpandedQuestionViewController.swift
//  Edus
//
//  Created by michael ninh on 11/12/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit

class ExpandedQuestionViewController: UIViewController {
    
    //posts get passed in using a segue
    //segue auto occurs since this is a child controller
    
    
    @IBOutlet weak var postTitleText: UILabel!
    @IBOutlet weak var contentText: UILabel!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    
    @IBAction func upVote(sender: AnyObject) {
    }
    
    
    @IBAction func deletePost(sender: AnyObject) {
    }
    
    
    @IBAction func flagPost(sender: AnyObject) {
    }
    
    var targetPost: Post?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        dateText.text = targetPost!.createdAt?.shortTimeAgoSinceDate(NSDate()) ?? ""
        postTitleText.text = targetPost!.title
        contentText.text = targetPost!.content
        nameText.text = targetPost!.fromUserName
        scoreText.text = String(targetPost!.toPostPoints.score)
        
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
