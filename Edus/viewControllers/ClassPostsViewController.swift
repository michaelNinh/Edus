//
//  ClassPostsViewController.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import Parse
import ConvenienceKit


class ClassPostsViewController: UIViewController {
    
    var classroom: Classroom?

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //this is how I pass the class data from the tabBar into this controller
        if self.tabBarController != nil{
            let tabBarReference = self.tabBarController as! ClassTabBarViewController
            self.classroom = tabBarReference.classroom
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /*
        if (segue.identifier == "ExpandPost") {
            let expandedPostViewController = segue.destinationViewController as! ExpandedPostViewController
            expandedPostViewController.post = selectedPost
        }
*/
        if (segue.identifier == "makePostSegue") {
            let makePostViewController = segue.destinationViewController as! MakePostViewController
            makePostViewController.classroom = self.classroom
        }
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
