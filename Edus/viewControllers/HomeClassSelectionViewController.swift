//
//  HomeClassSelectionViewController.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import Parse

protocol loggingOut{
    func loggerOuter()
}

class HomeClassSelectionViewController: UIViewController {
    

    var enrolledClasses: [Classroom] = []
    var selectedClassroom: Classroom?
    static var delegate: loggingOut!

    @IBOutlet weak var addSchoolButton: UIButton!
    @IBAction func addSchool(sender: AnyObject) {
    }
    @IBOutlet weak var logOut: UIButton!
    @IBAction func logOut(sender: AnyObject) {
        
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            //if error == nil {
            //we need to set the delegate! gooknna look my code haha
            
            if PFUser.currentUser() == nil {

                print("log out worked")
                HomeClassSelectionViewController.delegate.loggerOuter()
            } else {
                print("log out did not work")
                //SCLAlertView().showInfo("Log out", subTitle: "Log out did not work. Check your Internet connection and try again")
            }
        }
        
    }
    
    @IBOutlet weak var userNameText: UILabel!
    
    @IBOutlet weak var enrolledClassesTableView: UITableView!
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        print("appeared")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkActiveSchoolButtonText()
        userNameText.text = PFUser.currentUser()?.username!
    
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
    
    //FUNCTION TO CHANGE ADD COLLEGE BUTTON TEXT
    func checkActiveSchoolButtonText(){
        if PFUser.currentUser()!["activeSchoolName"] == nil{
            addSchoolButton.setTitle("+ Set your school here", forState: .Normal)
        }else{
            let schoolName = PFUser.currentUser()!["activeSchoolName"]
            addSchoolButton.setTitle(schoolName as? String, forState: .Normal)
        }
    }
    

}

extension HomeClassSelectionViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedClassroom = enrolledClasses[indexPath.row]
        enterClassSegue()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    //this is for deleting a class
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            self.selectedClassroom = enrolledClasses[indexPath.row]
            self.selectedClassroom?.deleteClass(self.selectedClassroom!)
            self.enrolledClasses.removeAtIndex(indexPath.row)
            self.enrolledClassesTableView.reloadData()
        }
    }

    
    
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