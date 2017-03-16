//
//  SocialNetworkViewController.swift
//  ParticipACAO
//
//  Created by Evandro Henrique Couto de Paula on 22/01/16.
//  Copyright © 2016 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import Parse
import TwitterKit
import FBSDKMessengerShareKit
import FBSDKShareKit



class SocialNetworkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: -Twitter
    
    func shareTopicOnTwitter (objectId:String) {
        
        let postQuery = PFQuery(className: "Topic")
        
        postQuery.getObjectInBackgroundWithId(objectId) { (post:PFObject?, error:NSError?) -> Void in
            
            if error == nil {
                
                // it verifies if post has an image related with
                if post!["image"] == nil {
                    
                    // if not it compose the twitter share content
                    let composer = TWTRComposer()
                    
                    //it sets the post text
                    composer.setText(post!.valueForKey("subject") as? String)
                    
                    // and int verifies if the share was successful
                    composer.showFromViewController(self, completion: { (twtrResult:TWTRComposerResult) -> Void in
                        if twtrResult == .Done {
                            print("twitted")
                        }else if twtrResult == .Cancelled {
                            print("twitter cancelled")
                            
                        }
                    })
                    
                } else {
                    
                    let userImageFile = post!["image"] as! PFFile
                    
                    
                    userImageFile.getDataInBackgroundWithBlock({ (imageData:NSData?, error:NSError?) -> Void in
                        if error == nil {
                            if let imageData = imageData {
                                
                                let image = UIImage(data: imageData)
                                
                                let composer = TWTRComposer()
                                composer.setText(post!.valueForKey("subject") as? String)
                                composer.setImage(image)
                                composer.showFromViewController(self, completion: { (twtrResult:TWTRComposerResult) -> Void in
                                    if twtrResult == .Done {
                                        print("twitted")
                                    }else if twtrResult == .Cancelled {
                                        print("twitter cancelled")
                                    }
                                })
                                
                            }
                        }
                    })
                }
            }
        }
        
    }
    
    //used to share replys on twitter
    func shareReplyOnTwittwer(){
        
    }
    
    
    
    //MARK -Facebook
    
    //used to share replys on Facebook
    func shareReplyOnFacebook (objectId:String) {
        
        let shareContent = FBSDKShareLinkContent()
        shareContent.contentURL = NSURL(string: "http://e2rsolutions2k15.wix.com/r2e2solutionsxr")
//        shareContent.contentTitle = current["topic"]["title"] as? String
//        shareContent.contentDescription = current["content"] as? String
//        
//        
//        shareButton.frame = CGRectMake(cell.frame.width/2, cell.frame.height/4, 100, 40)
//        shareButton.shareContent = shareContent
//        cell.addSubview(shareButton)
        
    }
    
    
    func shareTopicOnFacebook(post:PFObject, viewController:UIViewController){
        
        /*let shareContent = FBSDKShareLinkContent()
        shareContent.contentURL = NSURL(string: "http://e2rsolutions2k15.wix.com/r2e2solutionsxr")
        
        shareContent.contentTitle       = "participAÇÃO app"
        shareContent.contentDescription = post.valueForKey("subject") as? String*/
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)  {
            
            if post["image"] == nil {
                
                let fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                fbShare.setInitialText(post.valueForKey("subject") as? String)
                
                viewController.presentViewController(fbShare, animated: true, completion: nil)
                
            } else {
                
                let userImageFile = post["image"] as! PFFile
                
                
                userImageFile.getDataInBackgroundWithBlock({ (imageData:NSData?, error:NSError?) -> Void in
                    if error == nil {
                        if let imageData = imageData {
                            
                            let image = UIImage(data: imageData)
                            
                            let fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                            
                            fbShare.addImage(image)
                            
                            fbShare.setInitialText(post.valueForKey("subject") as? String)
                            
                            viewController.presentViewController(fbShare, animated: true, completion: nil)

                            
                        }
                    }
                })

                
                
            }
            
            
        } else {
            
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            viewController.presentViewController(alert, animated: true, completion: nil)
        }
        
        
    

        
    }
    



}
