//
//  ExpandedPostViewController.swift
//  Edus
//
//  Created by michael ninh on 11/12/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import ConvenienceKit
import Parse
import DateTools

class ExpandedPostViewController: UIViewController, TimelineComponentTarget, ShowFlagAlertForReplyPost {
    
    
    @IBOutlet weak var questionTitleText: UILabel!
    @IBOutlet weak var questionContentText: UILabel!
    @IBOutlet weak var questionFromUserNameText: UILabel!
    @IBOutlet weak var questionDate: UILabel!
    @IBOutlet weak var questionScoreText: UILabel!
    
    @IBOutlet weak var questionUpvoteButton: UIButton!
    @IBAction func questionUpvote(sender: AnyObject) {
        targetPostPoints!.toPost = self.post
        targetPostPoints!.upVote()
        self.questionUpvoteButton.enabled = false
        questionScoreText.text = String(Int(questionScoreText.text!)!+1)
        
    }
    
    @IBAction func questionFlag(sender: AnyObject) {
        showFlagAlert("", message: "Flag for inappropriate content?")
    }
    @IBOutlet weak var questionDeleteButton: UIButton!
    @IBAction func questionDelete(sender: AnyObject) {
        showDeleteAlert("", message: "Delete post?")
    }
    
    
    
    
    //TIMELINE IMPLEMENTATION
    @IBOutlet weak var tableView: UITableView!
    let defaultRange = 0...4
    let additionalRangeSize = 5
    var timelineComponent: TimelineComponent<ReplyPost, ExpandedPostViewController>!
    
    //TIMELINE IMPLEMENTATION
    func loadInRange(range: Range<Int>, completionBlock: ([ReplyPost]?) -> Void) {
        
        GetReplyPostsForPost.getReplyPostsForPost({ (result: [PFObject]?, error: NSError?) -> Void in
            print (result?.count)
            let replyPosts = result as? [ReplyPost] ?? []
            completionBlock(replyPosts)
            }, post: self.post!, range: range)
    }
    
    var post: Post?
    var targetPostPoints: PostPoints?
    
    override func viewDidAppear(animated: Bool) {
        
        timelineComponent = TimelineComponent(target: self)
        timelineComponent.loadInitialIfRequired()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionContentText.text = self.post?.content
        self.questionTitleText.text = self.post?.title
        self.questionFromUserNameText.text = self.post?.fromUserName
        self.questionDate.text = self.post!.createdAt?.shortTimeAgoSinceDate(NSDate()) ?? ""
        
        if self.targetPostPoints != nil{
            self.questionScoreText.text = String(self.targetPostPoints!.score)
            if targetPostPoints!.voterList.contains(PFUser.currentUser()!.objectId!){
                print("already voted")
                questionUpvoteButton.enabled = false
            }else{
                questionUpvoteButton.enabled = true
            }
        }
        
        if self.post!.fromUserName == PFUser.currentUser()?.username{
            print("del enabled")
            questionDeleteButton.hidden = false
            questionDeleteButton.enabled = true
        }else{
            print("del dis")
            questionDeleteButton.hidden = true
            questionDeleteButton.enabled = false
        }
        
        
        timelineComponent = TimelineComponent(target: self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "displayPostSegue") {
            let expandedQuestionViewController = segue.destinationViewController as! ExpandedQuestionViewController
            expandedQuestionViewController.targetPost = self.post
        }
        
        if (segue.identifier == "writeReplyPostSegue") {
            let writePostReplyViewController = segue.destinationViewController as! WriteReplyPostViewController
            writePostReplyViewController.post = self.post
        }
        
    }
    
    @IBAction func unwindToExpandedPost(segue: UIStoryboardSegue) {
    }
    
    //ALERT STUFF
    func showFlagAlert(title: String, message: String){
        let alertController = UIAlertController(title: title , message: message, preferredStyle: .Alert);
        
        
        let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default){
            (actionCancel) -> () in
            print("do the flag")
            let postFlagger = PostFlag()
            postFlagger.toPost = self.post
            postFlagger.fromUser = PFUser.currentUser()
            postFlagger.toUser = self.post?.fromUser
            postFlagger.flagContent()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel){
            (actionCancel) -> () in
            print("action canceled")
        }
        
        alertController.addAction(yes)
        alertController.addAction(cancel)
        presentViewController(alertController, animated: true, completion: nil);
    }
    
    //DELETE STUFF
    
    func showDeleteAlert(title: String, message: String){
        let alertController = UIAlertController(title: title , message: message, preferredStyle: .Alert);
        
        
        let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default){
            (actionCancel) -> () in
            print("deleting post")
            self.post?.deletePost()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel){
            (actionCancel) -> () in
            print("action canceled")
        }
        
        alertController.addAction(yes)
        alertController.addAction(cancel)
        presentViewController(alertController, animated: true, completion: nil);
    }
    
    //ALERT FOR REPLYTABLECELLS
    func showFlagAlert(title: String, message: String, callbackViewCell: ReplyPostTableViewCell){
        let alertController = UIAlertController(title: title , message: message, preferredStyle: .Alert);
        
        
        let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default){
            (actionCancel) -> () in
            print("do the flag")
            callbackViewCell.flagContentAction()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel){
            (actionCancel) -> () in
            print("action canceled")
        }
        
        alertController.addAction(yes)
        alertController.addAction(cancel)
        presentViewController(alertController, animated: true, completion: nil);
    }
    
    
    
    
    func showDeleteAlert(title: String, message: String, callbackViewCell: ReplyPostTableViewCell){
        let alertController = UIAlertController(title: title , message: message, preferredStyle: .Alert);
        
        
        let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default){
            (actionCancel) -> () in
            print("do the flag")
            callbackViewCell.deleteContentAction()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel){
            (actionCancel) -> () in
            print("action canceled")
        }
        
        alertController.addAction(yes)
        alertController.addAction(cancel)
        presentViewController(alertController, animated: true, completion: nil);
    }

}



extension ExpandedPostViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.selectedPost = timelineComponent.content[indexPath.row]
        //expandPostSegue()
        
    }
    
}

extension ExpandedPostViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("found this number of posts:\(timelineComponent.content.count)")
        return timelineComponent.content.count
        //return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("replyPostCell") as! ReplyPostTableViewCell
        
        let replyPost = timelineComponent.content[indexPath.row]
        replyPost.setReplyPost()
        cell.replyPost = replyPost
        
        cell.delegate = self
        
        GetPointsForReplyPost.getPointsForReplyPost({ (result: [PFObject]?, error: NSError?) -> Void in
            if result!.count != 0{
                let targetPointObj = result![0] as! ReplyPostPoints
                targetPointObj.setReplyPoints()
                
                cell.scoreText.text = String(targetPointObj.score)
                
                if targetPointObj.voterList.contains(PFUser.currentUser()!.objectId!){
                    print("already voted")
                    cell.upVoteButton.enabled = false
                }else{
                    cell.upVoteButton.enabled = true
                }
                
            }else{
                print("no votes")
            }
            }, replyPost: replyPost)
        
        
        return cell
    }
}



