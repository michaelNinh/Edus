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
import ConvenienceKit

class SelectSchoolViewController: UIViewController, TimelineComponentTarget {
    
    @IBOutlet weak var tableView: UITableView!
    let defaultRange = 0...4
    let additionalRangeSize = 5
    
    var timelineComponent: TimelineComponent<School, SelectSchoolViewController>!
    
    func loadInRange(range: Range<Int>, completionBlock: ([School]?) -> Void) {
        
        GetAvailableSchools.getAvailableSchools({ (result: [PFObject]?, error: NSError?) -> Void in
            let availableSchools = result as? [School] ?? []
            for school in self.availableSchools{
                school.setSchoolName()
                completionBlock(availableSchools)
            }
            }, range: range)
        
    }
    
    var availableSchools: [School] = []
    var selectedSchool: School?

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
        self.selectedSchool = timelineComponent.content[indexPath.row]
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
        return timelineComponent.content.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("schoolCell") as! AvailableSchoolTableViewCell
        
        let school = timelineComponent.content[indexPath.row]
        
        
        cell.schoolOption.text = school.schoolName

        return cell
    }
    
    
}



