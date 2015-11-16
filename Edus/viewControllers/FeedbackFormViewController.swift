//
//  FeedbackFormViewController.swift
//  edus
//
//  Created by michael ninh on 9/10/15.
//  Copyright (c) 2015 Cognitus. All rights reserved.
//

import UIKit

class FeedbackFormViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var feedback = FeedbackModel()
    
    @IBOutlet weak var messageBox: UITextView!
    
    @IBAction func sendFeedback(sender: AnyObject) {
        self.feedback.message = messageBox.text
        self.feedback.uploadFeedback()
        showFeedbackAlert("", message: "Thanks for the feedback!")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageBox.text = "SHOW ME WHAT YOU GOT."
        messageBox.delegate = self
        messageBox.textColor = UIColor.lightGrayColor()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ALERT STUFF
    func showFeedbackAlert(title: String, message: String){
        let alertController = UIAlertController(title: title , message: message, preferredStyle: .Alert);
        
        
        let yes = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){
            (actionCancel) -> () in
            print("do the flag")
        }
        
        
        alertController.addAction(yes)
        presentViewController(alertController, animated: true, completion: nil);
    }
    
    //text placeHolderstuff
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "SHOW ME WHAT YOU GOT."
            textView.textColor = UIColor.lightGrayColor()
        }
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
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
