//
//  CUAppDelegate.swift
//  CurlUpMobileIOS
//
//  Created by Connor Reid on 2/8/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import UIKit

@UIApplicationMain
class CUAppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
//        sleep(30)
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        FBLoginView.self
       
        let loginViewController = CULoginViewController()
        let sidebarController = CUSideBarViewController()
        let mainNavigationController = UINavigationController(rootViewController: loginViewController)
        let revealController = SWRevealViewController(rearViewController: sidebarController, frontViewController: mainNavigationController)
        self.window?.rootViewController = revealController
        self.window?.makeKeyAndVisible()
        
        if FBSession.activeSession().state == FBSessionState.CreatedTokenLoaded
        {
            FBSession.openActiveSessionWithReadPermissions(["public_profile", "email"], allowLoginUI: false, completionHandler:
            {
                (session, state, error) -> Void in
                    self.sessionStateChanged(toSession: session, toState: state, withError: error)
            })
        }

        UINavigationBar.appearance().barTintColor = UIColor(red: 104/255, green: 199/255, blue: 199/255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().translucent = false
        
        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool
    {
        if let urlScheme: String = url.scheme
        {
            if urlScheme == "com.curlup.curlupmobileios"
            {
                return GPPURLHandler.handleURL(url, sourceApplication: sourceApplication, annotation: annotation)
            }
            else if urlScheme == "fb729895337124255"
            {
                FBSession.activeSession().setStateChangeHandler({(session, state, error) -> Void in
                    let appDelegate = UIApplication.sharedApplication().delegate as CUAppDelegate
                    appDelegate.sessionStateChanged(toSession: session, toState: state, withError: error)
                })
                return FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
            }
        }
        return false
    }
    
    func applicationWillResignActive(application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication)
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when IBInspectablethe user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication)
    {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBAppCall.handleDidBecomeActive()
    }
    
    func applicationWillTerminate(application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func sessionStateChanged(toSession session: FBSession, toState state: FBSessionState, withError error:NSError?)
    {
        if error == nil
        {
            if state == FBSessionState.Open
            {
                println("Session opened")
                // TODO show activity indicator
                FBRequest.requestForMe().startWithCompletionHandler({(connection, user, error) -> Void in
                    // TODO hide activity indicator
                    if error != nil
                    {
                        // TODO handle error
                    }
                    else
                    {
                        CUAccountProfile.sharedInstance.firstName = user.first_name
                        CUAccountProfile.sharedInstance.lastName = user.last_name
                        CUAccountProfile.sharedInstance.userName = "\(user.first_name) \(user.last_name)"
                        CUAccountProfile.sharedInstance.email = user.objectForKey("email") as String
                        CUAccountProfile.sharedInstance.facebookID = user.objectID
                        self.userLoggedIn()
                    }
                })
                return
            }
        }
        
        if state == FBSessionState.Closed
        {
            println("Session closed")
            self.userLoggedOut()   // TODO logged out UI
        }
        else if state == FBSessionState.ClosedLoginFailed
        {
            println("Session closed")
            self.userLoggedOut()   // TODO logged out UI
        }
        
        if error != nil
        {
            println("Error logging into Facebook")
            var alertText: String
            var alertTitle: String
            if FBErrorUtility.shouldNotifyUserForError(error) == true
            {
                alertText = FBErrorUtility.userMessageForError(error)
                alertTitle = "Something went wrong logging into Facebook. Please try again."
                self.logFacebookErrorMessage(fromAlertText: alertText, fromAlertTitle: alertTitle)
            }
            else
            {
                if FBErrorUtility.errorCategoryForError(error) == FBErrorCategory.UserCancelled
                {
                    println("User cancelled login")
                }
                else if FBErrorUtility.errorCategoryForError(error) == FBErrorCategory.AuthenticationReopenSession
                {
                    alertText = "Your current session is no longer valid. Please log in again."
                    alertTitle = "Session Error"
                    self.logFacebookErrorMessage(fromAlertText: alertText, fromAlertTitle: alertTitle)
                }
                else
                {
                    let errorUserInfoDictionary = error!.userInfo!
                    let facebookErrorParsedJsonResponseKeyDictionary: [NSObject: NSObject] = errorUserInfoDictionary["com.facebook.sdk:ParsedJSONResponseKey"]! as [NSObject: NSObject]
                    let facebookErrorBodyDictionary: [NSObject: NSObject] = facebookErrorParsedJsonResponseKeyDictionary["body"]! as [NSObject: NSObject]
                    let facebookErrorDictionary: [NSObject: NSObject] = facebookErrorBodyDictionary["error"]! as [NSObject: NSObject]
                    let facebookErrorMessage: String = facebookErrorDictionary["message"]! as String
                    
                    alertTitle = "Something went wrong"
                    alertText = "Please retry. \n\n If the problem persists contact us and mention this error code \(facebookErrorMessage)"
                    self.logFacebookErrorMessage(fromAlertText: alertText, fromAlertTitle: alertTitle)
                }
            }
            FBSession.activeSession().closeAndClearTokenInformation()
            self.userLoggedOut()
        }
    }
    
    func logFacebookErrorMessage(fromAlertText alertText: String, fromAlertTitle alertTitle: String)
    {
        println("\(alertText) \(alertTitle)")
    }
    
    func userLoggedIn()
    {
        println("User logged in")   // TODO logged in UI
        let mainViewViewController = CUMainViewController()
        let sidebarController = CUSideBarViewController()
        let mainNavigationController = UINavigationController(rootViewController: mainViewViewController)
        let revealController = SWRevealViewController(rearViewController: sidebarController, frontViewController: mainNavigationController)
        self.window?.rootViewController = revealController
        self.window?.makeKeyAndVisible()
    }
    
    func userLoggedOut()
    {
        FBSession.activeSession().closeAndClearTokenInformation()
        println("User logged out")   // TODO logged out UI
        let loginViewController = CULoginViewController()
        let sidebarController = CUSideBarViewController()
        let mainNavigationController = UINavigationController(rootViewController: loginViewController)
        let revealController = SWRevealViewController(rearViewController: sidebarController, frontViewController: mainNavigationController)
        self.window?.rootViewController = revealController
        self.window?.makeKeyAndVisible()
    }
}
