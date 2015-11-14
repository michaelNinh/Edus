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
        addedSchoolSegue()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addedSchoolSegue(){
        performSegueWithIdentifier("addedSchoolSegue", sender: self)
    }

}
