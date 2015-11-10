//
//  SelectSchoolViewController.swift
//  Edus
//
//  Created by michael ninh on 11/10/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import Parse

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SelectSchoolViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedSchool = availableSchools[indexPath.row]
        let currentUser = PFUser.currentUser()!
        currentUser["activeSchoolName"] = self.selectedSchool?.schoolName
        currentUser.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("User assigned school saved.")
        }
        //confirmSchoolAlert("You have selected \(self.selectedSchool!.schoolName!) as your active school", message: "")
        //let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        //mixpanel.track("school added")
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



