//
//  SelectSchoolViewController.swift
//  Edus
//
//  Created by michael ninh on 11/10/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import Parse
import Mixpanel

class SelectSchoolViewController: UIViewController {
    
    
    var availableSchools: [School] = []
    var selectedSchool: School?

    @IBOutlet weak var schoolTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetAvailableSchools.getClassesForUser { (result: [PFObject]?, error: NSError?) -> Void in
            print("the returned result number is \(result?.count)")
            self.availableSchools = result as? [School] ?? []
            for school in self.availableSchools{
                school.setSchoolName()
                self.schoolTableView.reloadData()
            }
        }
        self.schoolTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addedSchoolSegue(){
        performSegueWithIdentifier("clickAddSchoolSegue", sender: self)
    }

    
    //ALERT STUFF
    func confirmSchoolAlert(title: String, message: String){
        let alertController = UIAlertController(title: title , message: message, preferredStyle: .Alert);
        
        
        let yes = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){
            (actionCancel) -> () in
            self.addedSchoolSegue()
        }
        
        
        alertController.addAction(yes)
        presentViewController(alertController, animated: true, completion: nil);
    }
    
}

extension SelectSchoolViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedSchool = availableSchools[indexPath.row]
        let currentUser = PFUser.currentUser()!
        //this code adds a new colm into parse database -> transfer this over to adding new school as well
        currentUser["activeSchoolName"] = self.selectedSchool?.schoolName
        currentUser["activeSchool"] = self.selectedSchool
        currentUser.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("User assigned school saved.")
        }
        
        confirmSchoolAlert("You have selected \(self.selectedSchool!.schoolName!) as your active school", message: "")
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("School added")
    }
}

extension SelectSchoolViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableSchools.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("schoolCell") as! AvailableSchoolTableViewCell
        //the tableViewCell post is equal to the post[arrayNumber]
        cell.schoolOption.text = availableSchools[indexPath.row].schoolName

        return cell
    }
    
    
}



