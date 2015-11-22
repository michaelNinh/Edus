//
//  SubjectListViewController.swift
//  Edus
//
//  Created by michael ninh on 11/10/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import Parse
import ConvenienceKit


class SubjectListViewController: UIViewController, TimelineComponentTarget {
    
    var subjectList: [SubjectList] = []
    var selectedSubject: SubjectList?

    //TIMELINE IMPLE
    @IBOutlet weak var tableView: UITableView!
    let defaultRange = 0...99
    let additionalRangeSize = 10
    var timelineComponent: TimelineComponent<SubjectList, SubjectListViewController>!
    func loadInRange(range: Range<Int>, completionBlock: ([SubjectList]?) -> Void) {
        
        GetSubjectList.getSubjectList({ (result: [PFObject]?, error: NSError?) -> Void in
            let subjectList = result as? [SubjectList] ?? []
            completionBlock(subjectList)
        }, range: range)
        
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        
        timelineComponent.loadInitialIfRequired()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timelineComponent = TimelineComponent(target: self)

        /*
        GetSubjectList.getSubjectList { (result:[PFObject]?, error: NSError?) -> Void in
            self.subjectList = result as? [SubjectList] ?? []
            for subject in self.subjectList{
                subject.setSubjectName()
                print(subject.subjectName)
                self.subjectListTableView.reloadData()
            }
            self.subjectListTableView.reloadData()

        }
        
        subjectListTableView.reloadData()
*/
    }
    
    func passBackSegue(){
        self.performSegueWithIdentifier("selectedSubjectSegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "selectedSubjectSegue") {
            let createNewClassViewController = segue.destinationViewController as! CreateNewClassViewController
            createNewClassViewController.selectedSubject = self.selectedSubject
        }
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


extension SubjectListViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedSubject = timelineComponent.content[indexPath.row]
        self.passBackSegue()
        
        //this should call a "prepare for segue" and pass back the selected subject
        }
        //confirmSchoolAlert("You have selected \(self.selectedSchool!.schoolName!) as your active school", message: "")
        //let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        //mixpanel.track("school added")
    }


extension SubjectListViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelineComponent.content.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("subjectCell") as! SubjectListTableViewCell
        //the tableViewCell post is equal to the post[arrayNumber]
        
        let subject = timelineComponent.content[indexPath.row] as? SubjectList
        
        subject?.setSubjectName()
        
        cell.subjectOption.text = subject?.subjectName
        
        return cell
    }
    
    
}


