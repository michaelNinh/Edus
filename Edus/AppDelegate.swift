//
//  AppDelegate.swift
//  Edus
//
//  Created by michael ninh on 11/9/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI
import FBSDKCoreKit
import Mixpanel

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var parseLoginHelper: ParseLoginHelper!
    
    override init() {
        super.init()
        
        parseLoginHelper = ParseLoginHelper {[unowned self] user, error in
            // Initialize the ParseLoginHelper with a callback
            if let error = error {
                // 1
                ErrorHandling.defaultErrorHandler(error)
            } else  if let user = user {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //creation
                let classNavEntry = storyboard.instantiateViewControllerWithIdentifier("ClassNavEntry")
                //presentation
                self.window?.rootViewController!.presentViewController(classNavEntry, animated:true, completion:nil)
            }
        }
    }
    
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Mixpanel.sharedInstanceWithToken("18e2baa20408d29e0d3104cfb2c90c9d")
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("App launched")
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        Parse.enableLocalDatastore()
       
        Parse.setApplicationId("n0VDpunIf6wmtPJaOSGHRjRjaeFPHtt2aLzWOASq",
            clientKey: "YLHnqErlxm35J64dMJ514qxAyn4OYfGO3JDfCtpf")
       
        let user = PFUser.currentUser()
        
        let startViewController: UIViewController
        
        if (user != nil) {
            // 3
            // if we have a user, set the ClassNavEntry to be the initial View Controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //problem may arise here
            startViewController =
                storyboard.instantiateViewControllerWithIdentifier("ClassNavEntry") as! UINavigationController
        } else {
            // 4
            // Otherwise set the LoginViewController to be the first
            let loginViewController = PFLogInViewController()
            loginViewController.fields = [.UsernameAndPassword, .LogInButton, .SignUpButton, .PasswordForgotten]
            loginViewController.delegate = parseLoginHelper
            loginViewController.signUpController?.delegate = parseLoginHelper
            startViewController = loginViewController
            
            let roseColor = UIColor(red: 210/255, green: 77/255, blue: 87/255, alpha: 1)
            loginViewController.view.backgroundColor = roseColor
            let logoView = UIImageView(image: UIImage(named: "logInLogo.png"))
            loginViewController.logInView?.logo = logoView
            
            loginViewController.signUpController?.view.backgroundColor = roseColor
            loginViewController.signUpController?.signUpView?.logo = nil
        }
        
        // 5
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = startViewController
        self.window?.makeKeyAndVisible()
        
        
        //PFUser.logInWithUsername("test", password: "test")
        
        if let user = PFUser.currentUser() {
            print("Log in successful")
        } else {
            print("No logged in user :(")
        }
        
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        //let acl = PFACL()
        //acl.setPublicReadAccess(true)
        //PFACL.setDefaultACL(acl, withAccessForCurrentUser: true)
        
        
        
        
        
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    //facebook integration
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}







/*
import UIKit
import Parse
import Bolts
import ParseUI
import FBSDKCoreKit
import Mixpanel
//import ParseCrashReporting


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var parseLoginHelper: ParseLoginHelper!
    
    /*
    func loggerOuter() {
        //LOG IN STUFF
        let user = PFUser.currentUser()
        
        let startViewController: UIViewController
        
        if (user != nil) {
            // 3
            // if we have a user, set the ClassNavEntry to be the initial View Controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //problem may arise here
            startViewController =
                storyboard.instantiateViewControllerWithIdentifier("ClassNavEntry") as! UINavigationController
        } else {
            // 4
            // Otherwise set the LoginViewController to be the first
            let loginViewController = PFLogInViewController()
            loginViewController.fields = [.UsernameAndPassword, .LogInButton, .SignUpButton, .PasswordForgotten]
            loginViewController.delegate = parseLoginHelper
            loginViewController.signUpController?.delegate = parseLoginHelper
            startViewController = loginViewController
            
            let roseColor = UIColor(red: 210/255, green: 77/255, blue: 87/255, alpha: 1)
            loginViewController.view.backgroundColor = roseColor
            let logoView = UIImageView(image: UIImage(named: "logInLogo.png"))
            loginViewController.logInView?.logo = logoView
            
            loginViewController.signUpController?.view.backgroundColor = roseColor
            loginViewController.signUpController?.signUpView?.logo = nil
        }
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = startViewController
        self.window?.makeKeyAndVisible()
    }
*/
    
    override init() {
        super.init()
        //HomeClassSelectionViewController.delegate = self // I have the power over HomeClassSelectionViewController! :)
        parseLoginHelper = ParseLoginHelper {[unowned self] user, error in
            // Initialize the ParseLoginHelper with a callback
            if let error = error {
                // 1
                ErrorHandling.defaultErrorHandler(error)
            } else  if let user = user {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //creation
                let classNavEntry = storyboard.instantiateViewControllerWithIdentifier("ClassNavEntry")
                //presentation
                self.window?.rootViewController!.presentViewController(classNavEntry, animated:true, completion:nil)
            }
        }
    }



    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Override point for customization after application launch.
        
        
        Mixpanel.sharedInstanceWithToken("18e2baa20408d29e0d3104cfb2c90c9d")
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("App launched")
        
        //ParseCrashReporting.enable();

        Parse.enableLocalDatastore()

        Parse.setApplicationId("n0VDpunIf6wmtPJaOSGHRjRjaeFPHtt2aLzWOASq",
            clientKey: "YLHnqErlxm35J64dMJ514qxAyn4OYfGO3JDfCtpf")
       UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        

       //loggerOuter()
        
        let user = PFUser.currentUser()
        
        let startViewController: UIViewController
        
        if (user != nil) {
            // 3
            // if we have a user, set the ClassNavEntry to be the initial View Controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //problem may arise here
            startViewController =
                storyboard.instantiateViewControllerWithIdentifier("ClassNavEntry") as! UINavigationController
        } else {
            // 4
            // Otherwise set the LoginViewController to be the first
            let loginViewController = PFLogInViewController()
            loginViewController.fields = [.UsernameAndPassword, .LogInButton, .SignUpButton, .PasswordForgotten]
            loginViewController.delegate = parseLoginHelper
            loginViewController.signUpController?.delegate = parseLoginHelper
            startViewController = loginViewController
            
            let roseColor = UIColor(red: 210/255, green: 77/255, blue: 87/255, alpha: 1)
            loginViewController.view.backgroundColor = roseColor
            let logoView = UIImageView(image: UIImage(named: "logInLogo.png"))
            loginViewController.logInView?.logo = logoView
            
            loginViewController.signUpController?.view.backgroundColor = roseColor
            loginViewController.signUpController?.signUpView?.logo = nil
        }
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = startViewController
        self.window?.makeKeyAndVisible()
        
        
        //PFUser.logInWithUsername("test", password: "test")
        
        if let user = PFUser.currentUser() {
            print("Log in successful")
        } else {
            print("No logged in user :(")
        }
        //END LOGIN
        
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        //DETERMINE SECURITY ACCESS
        let acl = PFACL()
        acl.setPublicReadAccess(true)
        PFACL.setDefaultACL(acl, withAccessForCurrentUser: true)
        
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
*/
