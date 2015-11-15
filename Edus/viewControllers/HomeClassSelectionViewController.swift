//
//  HomeClassSelectionViewController.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import Parse

class HomeClassSelectionViewController: UIViewController {
    
    var enrolledClasses: [Classroom] = []
    var selectedClassroom: Classroom?

    @IBOutlet weak var addSchoolButton: UIButton!
    @IBAction func addSchool(sender: AnyObject) {
    }
    @IBOutlet weak var logOut: UIButton!
    @IBAction func logOut(sender: AnyObject) {
        
    }
    
    @IBOutlet weak var userNameText: UILabel!
    
    @IBOutlet weak var enrolledClassesTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //this query would be called getUserEnrolledClasses
        let query = PFQuery(className: "_User")
        query.includeKey("enrolledClasses")
        query.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)
        
        
        query.findObjectsInBackgroundWithBlock { (userResult:[PFObject]?, error:NSError?) -> Void in
            
            let thisUser = userResult![0] as! PFUser
            //add NIL CATCH HERE
            if thisUser["enrolledClasses"] != nil{
            self.enrolledClasses = thisUser["enrolledClasses"] as! [Classroom]
            for classroom in self.enrolledClasses{
                classroom.setClass()
                self.enrolledClassesTableView.reloadData()
                }
            }else{
                print("not enrolled in any classes yet")
            }
            
            
            self.enrolledClassesTableView.reloadData()
        }
        //end query


    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "enterClassSegue") {
            let classTabBarViewController = segue.destinationViewController as! ClassTabBarViewController
            classTabBarViewController.classroom = self.selectedClassroom
        
        }
    }
    
    func enterClassSegue(){
        self.performSegueWithIdentifier("enterClassSegue", sender: self)
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

extension HomeClassSelectionViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedClassroom = enrolledClasses[indexPath.row]
        enterClassSegue()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    /*
    //this is for deleting a class
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            self.selectedClass = classrooms[indexPath.row]
            self.selectedClass?.deleteClass(self.selectedClass!.objectId!)
            self.classListTable.reloadData()
        }
    }
*/
    
    
}

extension HomeClassSelectionViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return enrolledClasses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("enrolledClassCell") as! EnrolledClassesTableViewCell
        //the tableViewCell post is equal to the post[arrayNumber]
        cell.enrolledOption.text = enrolledClasses[indexPath.row].classTitle
        
        return cell
    }
    
    
}