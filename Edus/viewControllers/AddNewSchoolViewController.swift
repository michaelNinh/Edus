//
//  AddNewSchoolViewController.swift
//  Edus
//
//  Created by michael ninh on 11/9/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import Parse

class AddNewSchoolViewController: UIViewController {
    
    

    @IBOutlet weak var schoolNameTextField: UITextField!
    
    @IBAction func addNewSchoolButton(sender: AnyObject) {
        
        let newSchool = School()
        newSchool.schoolName = self.schoolNameTextField.text
        //newSchool.enrolledUsers.append(PFUser.currentUser()!)
        newSchool.createNewSchool()
        print("button pressed")
        
    }
    
    
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
