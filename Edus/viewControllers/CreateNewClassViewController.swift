//
//  CreateNewClassViewController.swift
//  Edus
//
//  Created by michael ninh on 11/10/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import Parse

class CreateNewClassViewController: UIViewController {
    
    var passedBackSubject: String? = "lul"
    
    @IBOutlet weak var classNameField: UITextField!
    @IBOutlet weak var professorLastNameField: UITextField!
    
    @IBAction func subjectButton(sender: AnyObject) {
    }
    @IBOutlet weak var subjectText: UIButton!
    
    @IBOutlet weak var levelSegementControlButton: UISegmentedControl!
    
    
    @IBAction func addClassButton(sender: AnyObject) {
        var classroom = Classroom()
        classroom.classTitle = self.classNameField.text
        classroom.professorLastName = self.professorLastNameField.text
        classroom.subject = self.passedBackSubject
        
        
        switch levelSegementControlButton.selectedSegmentIndex{
        case 0:
            classroom.subjectLevel = "Intro"
            print("intro")
        case 1:
            classroom.subjectLevel = "Intermediate"
        case 2:
            classroom.subjectLevel = "Advanced"
        default:
            break;
        }
        
        
        classroom.enrollClass()
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
