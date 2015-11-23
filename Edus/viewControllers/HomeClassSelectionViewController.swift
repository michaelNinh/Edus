//
//  HomeClassSelectionViewController.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import Parse
import ConvenienceKit

protocol loggingOut{
    func loggerOuter()
}

class HomeClassSelectionViewController: UIViewController, TimelineComponentTarget {
    
    //timeline implementation
    let defaultRange = 0...20
    let additionalRangeSize = 5
    var timelineComponent: TimelineComponent<Classroom, HomeClassSelectionViewController>!
    
    //TIMELINE IMPLEMENTATION
    func loadInRange(range: Range<Int>, completionBlock: ([Classroom]?) -> Void) {
        Classroom.registerSubclass()
        
        let query = PFQuery(className: "_User")
        query.includeKey("enrolledClasses")
        query.getObjectInBackgroundWithId(PFUser.currentUser()!.objectId!) {(result:PFObject?, error: NSError?) -> Void in
            /*
            let rawPFObject = result!["enrolledClasses"] as! [PFObject]
            var classroomArray: [Classroom] = []
            
            for rawClassroom in rawPFObject{
                let convertedClassroom = Classroom()
                convertedClassroom.classTitle = rawClassroom["classTitle"] as? String
                convertedClassroom.subject = rawClassroom["subject"] as? String
                convertedClassroom.professorLastName = rawClassroom["professorLastName"] as? String
                convertedClassroom.subjectLevel = rawClassroom["classTitle"] as? String
                classroomArray.append(convertedClassroom)
            }
           
            completionBlock(classroomArray)
*/
            
            let userEnrolledClasses = result!["enrolledClasses"] as! [Classroom]
            completionBlock(userEnrolledClasses)
        }
    }
        
    
    
    var enrolledClasses: [Classroom] = []
    var selectedClassroom: Classroom?
    
    //static var delegate: loggingOut!

    @IBOutlet weak var addSchoolButton: UIButton!
    @IBAction func addSchool(sender: AnyObject) {
    }
    @IBAction func addClass(sender: AnyObject) {
        forceAddCollegePrompt()
    }
    @IBOutlet weak var logOut: UIButton!
    @IBAction func logOut(sender: AnyObject) {
        
        /*
        
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            //if error == nil {
            
            if PFUser.currentUser() == nil {

                print("log out worked")
                HomeClassSelectionViewController.delegate.loggerOuter()
            } else {
                print("log out did not work")
                //SCLAlertView().showInfo("Log out", subTitle: "Log out did not work. Check your Internet connection and try again")
            }
        }
*/
        
    }
    
    @IBOutlet weak var userNameText: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        print("appeared")
        timelineComponent.loadInitialIfRequired()

        
        /*
        //this query would be called getUserEnrolledClasses
        let query = PFQuery(className: "_User")
        query.includeKey("enrolledClasses")
        query.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)
        query.findObjectsInBackgroundWithBlock { (userResult:[PFObject]?, error:NSError?) -> Void in
            //sometimes SHIT CRASHES HERE
            let thisUser = userResult![0] as! PFUser
            //add NIL CATCH HERE
            if thisUser["enrolledClasses"] != nil{
                self.enrolledClasses = thisUser["enrolledClasses"] as! [Classroom]
                for classroom in self.enrolledClasses{
                    classroom.setClass()
                    self.tableView.reloadData()
                }
            }else{
                print("not enrolled in any classes yet")
            }
            
            
            self.tableView.reloadData()
        }
*/

        //end query
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timelineComponent = TimelineComponent(target: self)

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
    
    @IBAction func unwindToHomeClassSelection(segue: UIStoryboardSegue) {
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
    
    //force ADD COLLEGE
    func forceAddCollegePrompt(){
        if PFUser.currentUser()!["activeSchoolName"] == nil{
            showMissingCollegeAlert("Whoa, hold on there!", message: "Select your school first.")
        }else{
            self.performSegueWithIdentifier("addClassSegue", sender: self)
        }
    }
    
    //alert for missing college
    func showMissingCollegeAlert(title: String, message: String){
        let alertController = UIAlertController(title: title , message: message, preferredStyle: .Alert);
        
        
        let yes = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){
            (actionCancel) -> () in
            self.performSegueWithIdentifier("addSchoolSegue", sender: self)
        }
        
        
        
        alertController.addAction(yes)
        presentViewController(alertController, animated: true, completion: nil);
    }
    
    
}

extension HomeClassSelectionViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedClassroom = timelineComponent.content[indexPath.row]
        enterClassSegue()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    //this is for deleting a class -> HAVE TO EDIT FOR CONVENIENCE KIT
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            self.selectedClassroom = timelineComponent.content[indexPath.row]
            self.selectedClassroom?.deleteClass(self.selectedClassroom!)
            timelineComponent.content.removeAtIndex(indexPath.row)
        }
    }

    
    
}

extension HomeClassSelectionViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelineComponent.content.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("enrolledClassCell") as! EnrolledClassesTableViewCell
        //the tableViewCell post is equal to the post[arrayNumber]
        let classroom = timelineComponent.content[indexPath.row] as? Classroom
        print(timelineComponent.content[0])
        classroom?.setClass()
        cell.enrolledOption.text = classroom?.classTitle
        return cell
    }
    
    
    
}