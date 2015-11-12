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

    @IBOutlet weak var tableView: UITableView!
    let defaultRange = 0...4
    let additionalRangeSize = 5
    var timelineComponent: TimelineComponent<Post, ClassPostsViewController>!

    //TIMELINE IMPLEMENTATION
    func loadInRange(range: Range<Int>, completionBlock: ([Post]?) -> Void) {
        
        
        /*
        PostParseQueryHelper.getPostForClassCode({ (result: [AnyObject]?, error: NSError?) -> Void in
            let posts = result as? [Post] ?? []
            completionBlock(posts)
            }, classCode: self.classroom!.classCode!, range: range)
*/

        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /*
        if (segue.identifier == "ExpandPost") {
            let expandedPostViewController = segue.destinationViewController as! ExpandedPostViewController
            expandedPostViewController.post = selectedPost
        }
*/
        if (segue.identifier == "makePostSegue") {
            let makePostViewController = segue.destinationViewController as! MakePostViewController
            makePostViewController.classroom = self.classroom
        }
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

extension ClassPostsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelineComponent.content.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell") as! ClassPostTableViewCell
        
        let post = timelineComponent.content[indexPath.row]
        print(post)
        //post.setPost()
        
        
        
        cell.post = post
        //cell.delegate = self
        return cell
    }
}


