//
//  AppDelegate.swift
//  participAÇÃO
//
//  Created by Evandro Henrique Couto de Paula on 08/10/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import CoreData
import Parse
import Bolts
import FBSDKCoreKit
import ParseFacebookUtilsV4
import Social
import ParseTwitterUtils
import Fabric
import TwitterKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //  Setup UI
//        UINavigationBar.appearance().barTintColor = UIColor(red: 37.0/255.0, green: 168.0/255.0, blue: 252.0/255.0, alpha: 1)
         UINavigationBar.appearance().barTintColor = UIColor(red: 65.0/255.0, green: 175.0/255.0, blue: 216.0/255.0, alpha: 1)
        if let barFont = UIFont(name: "Hallo sans Light", size: 22.0) {
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName:barFont]
        }
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        UITabBar.appearance().tintColor = UIColor(red: 64.0/255.0, green: 248.0/255.0, blue: 255.0/255.0, alpha: 1)
//        UITabBar.appearance().tintColor = UIColor(red: 29.0/255.0, green: 173.0/255.0, blue: 234.0/255.0, alpha: 1)
        
        
        // Override point for customization after application launch.
        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios_guide#localdatastore/iOS
        //Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("N6xC8BC8UHA1irQZukc4RfESYL0BEOpHF5YXcjdi",
            clientKey: "VGrU9DLtp0zANp7jhKfVtUBlqHb4wAq9bOPcsjvE")
        
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        
        //Twitter with parse
        PFTwitterUtils.initializeWithConsumerKey("xZOvgZMWWaNAXsMGsSrFpZpkQ",  consumerSecret:"DWNStEHjNworSx5WxunZ3pAkWoue976rwx0Zvmn5gNkdlFp8gG")
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        
        
        //Twitter
        Fabric.with([Twitter.self])
        
        
        if(PFUser.currentUser() != nil){
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("tabViewController") as UIViewController
            //self.presentViewController(vc, animated: true, completion: nil)
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }

        
        return true
        
        
        //return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
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
        
        FBSDKAppEvents.activateApp()
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let canOpen = FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication!, annotation: annotation)
        print("open url = \(canOpen)")
        return canOpen
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        DataBaseManager.sharedInstance.saveContext()
    }


}

