//
//  AddClassViewController.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import Parse


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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddClassViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedClass = classrooms[indexPath.row]
        self.selectedClass?.addIntoClass()
        //enterClassSegue()
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