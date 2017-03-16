//
//  ViewController.swift
//  participAÇÃO
//
//  Created by Evandro Henrique Couto de Paula on 08/10/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import Parse
import FBSDKLoginKit
import FBSDKCoreKit
import TwitterKit
import ParseFacebookUtilsV4
import ParseUI
import Social
import Accounts
import ParseTwitterUtils


class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate  {
    
    var imageProfile: UIImage?
    //let permissions = ["public_profile", "email"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    //MARK: - Structure of views
    //function for create the main view
    func logInScreen(){
        
        
        if (PFUser.currentUser() == nil) {
            let loginViewController = MyLoginViewController()
            let signView = SignUpViewController()
            loginViewController.delegate = self
            loginViewController.fields = [.UsernameAndPassword, .LogInButton , .PasswordForgotten , .SignUpButton ,.Twitter, .Facebook , .DismissButton]
            loginViewController.facebookPermissions = ["public_profile", "email"]
            //loginViewController.emailAsUsername = true
            //loginViewController.signUpController?.delegate = self
            signView.delegate = self
            self.presentViewController(loginViewController, animated: false, completion: nil)
            
        }else{
            
            presentLoggedInAlert()
            
        }

        
    }
    
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        
        if !PFFacebookUtils.isLinkedWithUser(user) && !PFTwitterUtils.isLinkedWithUser(user){
            if user.isNew {
                user["isTracked"] = false;
            }
        }
        
        if(PFFacebookUtils.isLinkedWithUser(user)){
            
            if user.isNew{
                
                
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"name, email"], tokenString:accessToken, version: nil, HTTPMethod: "GET")
                request.startWithCompletionHandler({ (connection, result, error) -> Void in
                    if error == nil {
                        
                        let userId = result.valueForKey("id")
                        let name = result.valueForKey("name") as? String
                        let email = result.valueForKey("email") as? String
                        
                        
                        let pictureRequest = FBSDKGraphRequest(graphPath: "me/picture?type=large&redirect=false", parameters: nil)
                        pictureRequest.startWithCompletionHandler({
                            (connection, result, error: NSError!) -> Void in
                            if error == nil {
                                print("Imagem: \(result["data"]!["url"])")
                                
                                //User Image
                                let url = NSURL(string: result["data"]!["url"] as! String)
                                let urlRequest = NSURLRequest(URL: url!)
                                NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                                    let image = UIImage(data: data!)
                                    let userImage = UIImageJPEGRepresentation(image!, 1.0)
                                    let imageFile: PFFile = PFFile(name: (user.objectId! + " profileImage.jpg"), data:userImage!)
                                    user["picture_profile"] = imageFile
                                    user.username = name
                                    user.email = email
                                    user["isTracked"] = false;
                                    user.saveInBackground()
                                    print("id \(userId)nome: \(name)  email: \(email)")

                                })
                                
                                
                            } else {
                                print("\(error)")
                            }
                        })

                        
                    }else{
                        print("erro \(error.localizedDescription)")
                    }
                })
                

            }else{
                print("logged in")
            }
            
            
        } else if(PFTwitterUtils.isLinkedWithUser(user)){
            
            if user.isNew{
                
                let twitterUserName     = PFTwitterUtils.twitter()?.screenName
                PFUser.currentUser()?.username = twitterUserName
                
      
                let request = NSMutableURLRequest(URL: NSURL(string: "https://api.twitter.com/1.1/users/show.json?screen_name=" + twitterUserName!)!)
                PFTwitterUtils.twitter()?.signRequest(request)
                
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
//                    let image = UIImage(data: data!)
//                    let userImage = UIImageJPEGRepresentation(image!, 1.0)
//                    let imageFile: PFFile = PFFile(name: (user.objectId! + " profileImage.jpg"), data:userImage!)
//                    user["picture_profile"] = imageFile
                    
                    if error == nil {
                        
                        print("RESPOSTA TWITTER \(data)")
                        do{
                            let info = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                            
                            //let names: String! = info.objectForKey("name") as! String
                            
                           // let separatedNames: [String] = names.componentsSeparatedByString(" ")
                            
//                            self.firstName = separatedNames.first!
//                            self.lastName = separatedNames.last!
                            
                            
                            let urlString = info.objectForKey("profile_image_url_https") as! String
                            
                            let hiResUrlString = urlString.stringByReplacingOccurrencesOfString("_normal", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                            
                            
                            let twitterPhotoUrl = NSURL(string: hiResUrlString)
                            let requestPhoto = NSMutableURLRequest((URL: twitterPhotoUrl!))
                            PFTwitterUtils.twitter()?.signRequest(requestPhoto)
//                            NSURLConnection.sendAsynchronousRequest(requestPhoto, queue: NSOperationQueue.mainQueue(), completionHandler: { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
//                                
//                                let image = UIImage(data: data!)
//                                let userImage = UIImageJPEGRepresentation(image!, 1.0)
//                                let imageFile: PFFile = PFFile(name: (user.objectId! + " profileImage.jpg"), data:userImage!)
//                                user["picture_profile"] = imageFile
//                                //user.username = name
//                                //user.email = email
//                                user["isTracked"] = false;
//                                user.saveInBackground()
//                                //print("id \(userId)nome: \(name)  email: \(email)")
//                                
//                            })

                            
                        }catch{
                            
                            print("error serializing JSON: \(error)")
                        }
                        
                        
                    }
                    
                    
                })

                
                user["isTracked"]       = false;
                
                PFUser.currentUser()?.saveEventually()
                
            }else {
                
                print("twitter user loged in")
                
            }
            
        }
      
        

        self.dismissViewControllerAnimated(true, completion: nil)
        presentLoggedInAlert()
    }
    
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        
        user["isTracked"] = false
        user.saveInBackground()
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

    
    //this define the elements present in sign up view
    func signUpScreen(){
        let signUpController = SignUpViewController()
        signUpController.delegate = self
        
        signUpController.fields = [.UsernameAndPassword, .DismissButton, .Additional, .Email, .SignUpButton]
        
        self.presentViewController(signUpController, animated: true, completion: nil)
        
        
    }
    
    //Mark - Actions
    @IBAction func login(sender: AnyObject) {
        self.logInScreen()
    }
    
    @IBAction func signUp(sender: AnyObject) {
        //self.signUpScreen()
        let share = SocialNetworkViewController()
        
        let postQuery = PFQuery(className: "Topic")
        
        
        postQuery.getObjectInBackgroundWithId("LY6gkee6jM") { (post:PFObject?, error:NSError?) -> Void in
            
            share.shareTopicOnFacebook(post!, viewController: self)


        }

    }
    
}

