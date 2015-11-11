//
//  SubjectListViewController.swift
//  Edus
//
//  Created by michael ninh on 11/10/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit

class SubjectListViewController: UIViewController {
    
    var subjectList = ["Biology", "Organic Chemistry","Physics","Chemistry","Consulting","Finance","Accounting"]

    @IBOutlet weak var subjectListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

/*
extension SubjectListViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedSchool = availableSchools[indexPath.row]
        let currentUser = PFUser.currentUser()!
        //this code adds a new colm into parse database -> transfer this over to adding new school as well
        currentUser["activeSchoolName"] = self.selectedSchool?.schoolName
        currentUser.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("User assigned school saved.")
        }
        //confirmSchoolAlert("You have selected \(self.selectedSchool!.schoolName!) as your active school", message: "")
        //let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        //mixpanel.track("school added")
    }
}

extension SubjectListViewController: UITableViewDataSource {
    
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
*/

