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

class ExpandedPostViewController: UIViewController, TimelineComponentTarget {

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
    
    override func viewDidAppear(animated: Bool) {
        
        timelineComponent.loadInitialIfRequired()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return cell
    }
}



