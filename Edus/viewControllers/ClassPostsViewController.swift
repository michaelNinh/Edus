//
//  ClassPostsViewController.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import Parse
import ConvenienceKit


class ClassPostsViewController: UIViewController, TimelineComponentTarget {
    
    var classroom: Classroom?
    var selectedPost: Post?

    @IBOutlet weak var tableView: UITableView!
    let defaultRange = 0...4
    let additionalRangeSize = 5
    var timelineComponent: TimelineComponent<Post, ClassPostsViewController>!

    //TIMELINE IMPLEMENTATION
    func loadInRange(range: Range<Int>, completionBlock: ([Post]?) -> Void) {
        
        GetPostsForClass.getPostsForClass({ (result:[PFObject]?, error:NSError?) -> Void in
            let posts = result as? [Post] ?? []
            completionBlock(posts)
            }, classroom: self.classroom!, range: range)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        timelineComponent.loadInitialIfRequired()

        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //this is how I pass the class data from the tabBar into this controller
        if self.tabBarController != nil{
            let tabBarReference = self.tabBarController as! ClassTabBarViewController
            self.classroom = tabBarReference.classroom
        }
        
        timelineComponent = TimelineComponent(target: self)



        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func expandPostSegue(){
        self.performSegueWithIdentifier("expandPostSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "expandPostSegue") {
            let expandedPostViewController = segue.destinationViewController as! ExpandedPostViewController
            expandedPostViewController.post = selectedPost
        }

        if (segue.identifier == "makePostSegue") {
            let makePostViewController = segue.destinationViewController as! MakePostViewController
            makePostViewController.classroom = self.classroom
        }
    }
    

}

extension ClassPostsViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedPost = timelineComponent.content[indexPath.row]
        expandPostSegue()
       
    }
    
}

extension ClassPostsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("found this number of posts:\(timelineComponent.content.count)")
        return timelineComponent.content.count
        //return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell") as! ClassPostTableViewCell
        
        let post = timelineComponent.content[indexPath.row]
        post.setPost()
        print("why xcode why")
       
        cell.post = post
        //cell.delegate = self
        return cell
    }
}


