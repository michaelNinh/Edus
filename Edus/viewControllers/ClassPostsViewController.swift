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


class ClassPostsViewController: UIViewController, TimelineComponentTarget, ShowFlagAlert {
    
    var classroom: Classroom?
    var selectedPost: Post?
    var selectedPostPostPoints: PostPoints?

    
    
    @IBAction func backToHomeSegue(sender: AnyObject) {
        self.backToHomeSegue()
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    let defaultRange = 0...4
    let additionalRangeSize = 5
    var timelineComponent: TimelineComponent<Post, ClassPostsViewController>!

    //TIMELINE IMPLEMENTATION
    func loadInRange(range: Range<Int>, completionBlock: ([Post]?) -> Void) {
        
        GetPostsForClass.getPostsForClass({ (result:[PFObject]?, error:NSError?) -> Void in
            let posts = result as? [Post] ?? []
            print(posts)
            completionBlock(posts)
            }, classroom: self.classroom!, range: range)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        timelineComponent.loadInitialIfRequired()
        //timelineComponent = TimelineComponent(target: self)


        
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
    
    func backToHomeSegue(){
        self.performSegueWithIdentifier("backToHomeSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "expandPostSegue") {
            let expandedPostViewController = segue.destinationViewController as! ExpandedPostViewController
            expandedPostViewController.post = selectedPost
            expandedPostViewController.targetPostPoints = self.selectedPostPostPoints
        }

        if (segue.identifier == "makePostSegue") {
            let makePostViewController = segue.destinationViewController as! MakePostViewController
            makePostViewController.classroom = self.classroom
        }
    }
    
    //ALERT STUFF
    func showFlagAlert(title: String, message: String, callbackViewCell: ClassPostTableViewCell){
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
    
    
    
    
    func showDeleteAlert(title: String, message: String, callbackViewCell: ClassPostTableViewCell){
        let alertController = UIAlertController(title: title , message: message, preferredStyle: .Alert);
        
        
        let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default){
            (actionCancel) -> () in
            print("delete the post")
            callbackViewCell.deleteContentAction()
            self.tableView.reloadData()
            //DELETING DOES NOT UPDATE THE TABLEVIEW...minor issue
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
        cell.post = post
        cell.delegate = self
        
        GetPointsForPost.getPointsForPost({ (result: [PFObject]?, error: NSError?) -> Void in
            if result!.count != 0{
                let targetPointObj = result![0] as! PostPoints
                self.selectedPostPostPoints = targetPointObj
                targetPointObj.setPoints()
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
            }, post: post)
        
        
        if post.fromUserName == PFUser.currentUser()?.username{
            print("del enabled")
            cell.deleteButton.hidden = false
            cell.deleteButton.enabled = true
        }else{
            print("del dis")
            cell.deleteButton.hidden = true
            cell.deleteButton.enabled = false
        }
        
        return cell
    }
}


