//
//  AddNewSchoolViewController.swift
//  Edus
//
//  Created by michael ninh on 11/9/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import Parse
import Mixpanel

class AddNewSchoolViewController: UIViewController, UITextFieldDelegate {
    
    

    @IBOutlet weak var schoolNameTextField: UITextField!
    
    @IBAction func addNewSchoolButton(sender: AnyObject) {
        
        let newSchool = School()
        newSchool.schoolName = self.schoolNameTextField.text
        //newSchool.enrolledUsers.append(PFUser.currentUser()!)
        newSchool.createNewSchool()
        print("button pressed")
        addedSchoolSegue()
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("New school added")
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

    //MARK: Close keyboard
    
    /**
    * Called when 'return' key pressed. return NO to ignore.
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        self.view.endEditing(true)
    }
}
