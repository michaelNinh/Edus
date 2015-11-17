//
//  AddClassViewController.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import Parse
import Mixpanel


class AddClassViewController: UIViewController {
    
    var classrooms: [Classroom] = []
    var selectedClass: Classroom?

    @IBOutlet weak var classroomsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetClassForSchool.getClassForSchool { (result: [PFObject]?, error: NSError?) -> Void in
            self.classrooms = result as? [Classroom] ?? []
            for classroom in self.classrooms{
                classroom.setClass()
                self.classroomsTableView.reloadData()
            }
        }
        self.classroomsTableView.reloadData()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addedClassSegue(){
        performSegueWithIdentifier("clickAddClassSegue", sender: self)
    }
    
    //ALERT STUFF
    func confirmClassAlert(title: String, message: String){
        let alertController = UIAlertController(title: title , message: message, preferredStyle: .Alert);
        
        
        let yes = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){
            (actionCancel) -> () in
            let mixpanel: Mixpanel = Mixpanel.sharedInstance()
            mixpanel.track("Existing class added")
            self.addedClassSegue()
        }
        
        
        alertController.addAction(yes)
        presentViewController(alertController, animated: true, completion: nil);
    }
    
    
}

extension AddClassViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedClass = classrooms[indexPath.row]
        self.selectedClass?.addIntoClass()
        confirmClassAlert("You have added \(self.selectedClass!.classTitle!)", message: "")

    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
   
}

extension AddClassViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classrooms.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("classCell") as! AddClassTableViewCell
        //the tableViewCell post is equal to the post[arrayNumber]
        cell.classOptionLabel.text = classrooms[indexPath.row].classTitle
        return cell
    }
    
    
}