//
//  RulesViewController.swift
//  ParticipACAO
//
//  Created by Evandro Henrique Couto de Paula on 19/01/16.
//  Copyright © 2016 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import Parse

class RulesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func newReplyComplain(){
        
        //TODO: the button in the post to make possible the search by reply Id and insert the view to verify which is the reason for complan
        // also is necessary to verify if the complain about the reply already exists, if yes is  just necessary update the count
        
        
        let queryReply = PFQuery(className: "Reply")
        let query = PFQuery(className: "ReplyComplain")
        query.includeKey("user")
        query.includeKey("topic")
        do{
            query.whereKey("reply", equalTo: try queryReply.getObjectWithId("3nGNzya0oq"))
            
        }catch{
            
            print ("Error to get the reply")
        }
        
        var object:PFObject!
        
        let complain = PFObject(className: "ReplyComplain")
        
        
        query.findObjectsInBackgroundWithBlock { (result:[PFObject]?, error:NSError?) -> Void in
            
            if error == nil {
                
                //verify if already exist a complain related with that post
                if result != nil {
                    
                    if result?.count == 1{
                        //self.complain(result!)
                        result?[0].incrementKey("count", byAmount: 1)
                        result?[0].addObject(PFUser.currentUser()!, forKey: "complainers")
                        
                        result?[0].saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                            
                            if success {
                                
                                print("complain updated")
                                
                            } else {
                                
                                print("error to update complain")
                                
                            }
                        })
                        
                    }
                    
                }else {
                    
                    // it makes a search for the query reply using the reply id
                    do{
                        object = try query.getObjectWithId("3nGNzya0oq")
                        
                        
                    }catch{
                        
                        print("error to get the object")
                        
                    }
                    
                    
                    //self.complain(result!)
                    
                    //using the query results it inserts the the respose to create a new complain
                    complain["reply"] = object
                    complain["topic"] = object.valueForKey("topic")
                    complain["topicCreator"] = object.valueForKey("topic")?.valueForKey("user")
                    
                    
                    complain.incrementKey("count")
                    
                    
                    complain.addObject(PFUser.currentUser()!, forKey: "complainers")
                    
                    complain.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
                        if success {
                            
                            print("Complain saved")
                            
                        }else{
                            
                            print("Complain save failed")
                            
                        }
                    }
                    
                    
                }
            }
        }
        
        
        
        
        
        
        
    }
    
    
    
    func complain (result:PFObject) {
        //TODO ainda é necessário terminar o resto das aplições e funçoes de busca, mas a ideia de moderaçao está pronta,
        // esta parte precisa ser incluída na criação da queixa
        
        
        let complaint = UIAlertController(title: NSLocalizedString("Denuncia", comment: "title for Complaint"), message: NSLocalizedString("Qual o motivo da denuncia", comment: "Asking about the reason for the complaint"), preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let fakeTopic = UIAlertAction(title: NSLocalizedString("É uma postagem falsa", comment: "tell that is a fake topic"), style: .Default) { (alert:UIAlertAction) -> Void in
            result["isFake"] = true
            result.saveInBackground()
        }
        
        let offensiveTopic = UIAlertAction(title: NSLocalizedString("É ofensivo", comment: "tell that the post is offensive"), style: .Default) { (alert:UIAlertAction) -> Void in
            result["isOffensive"] = true
            result.saveInBackground()
            
        }
        let cancel = UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Cancel butotn"), style: .Cancel, handler: nil)
        
        complaint.addAction(fakeTopic)
        complaint.addAction(offensiveTopic)
        complaint.addAction(cancel)
        
        complaint.popoverPresentationController?.sourceView =  self.view
        self.presentViewController(complaint, animated: true, completion: nil)
        
    }
    
    
}