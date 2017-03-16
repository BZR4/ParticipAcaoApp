//
//  LoginViewController.swift
//  ParticipACAO
//
//  Created by Evandro Henrique Couto de Paula on 05/01/16.
//  Copyright © 2016 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import Parse
import TwitterKit
import ParseFacebookUtilsV4
import ParseUI
import Social
import Accounts
import ParseTwitterUtils
import FBSDKLoginKit
import FBSDKCoreKit



class LoginViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        if (PFUser.currentUser() == nil) {
//            let loginViewController = PFLogInViewController()
//            loginViewController.delegate = self
//            loginViewController.fields = [.UsernameAndPassword, .LogInButton , .PasswordForgotten , .SignUpButton , .Facebook , .Twitter]
//            loginViewController.emailAsUsername = true
//            loginViewController.signUpController?.delegate = self
//
//            self.presentViewController(loginViewController, animated: false, completion: nil)
//        }
    }
    
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        presentLoggedInAlert()
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        presentLoggedInAlert()
    }
    
    func presentLoggedInAlert() {
        let alertController = UIAlertController(title: "You're logged in", message: "Welcome", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showView(){
        if (PFUser.currentUser() == nil) {
            let loginViewController = PFLogInViewController()
            loginViewController.delegate = self
            loginViewController.fields = [.UsernameAndPassword, .LogInButton , .PasswordForgotten , .SignUpButton , .Facebook , .Twitter]
            loginViewController.emailAsUsername = true
            loginViewController.signUpController?.delegate = self
            
            self.presentViewController(loginViewController, animated: false, completion: nil)
            
        }else{
            presentLoggedInAlert()
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
