
//
//  LocationConfigViewController.swift
//  participAÇÃO
//
//  Created by Evandro Henrique Couto de Paula on 18/11/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import Parse

class LocationConfigViewController: UIViewController {

    //MARK: - properties
    @IBOutlet weak var switchLocation: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("User \(PFUser.currentUser())")
        
        self.readCurrentLocationStatus()

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
    
    @IBAction func switchAction(sender: UISwitch) {
        self.trackingOptions(sender)
    }
    
    
    /**
        function that defines the state of location of user based in the changes of a UISwitch.
     
        @param sender: UISwitch
     
     */
    func trackingOptions(sender:UISwitch){
        
        if(sender.on){
            let user = PFUser.currentUser()
            user!["isTracked"] = true
            user?.saveInBackground()
            
        }else{
            
            let user = PFUser.currentUser()
            user!["isTracked"] = false
            user?.saveInBackground()


        }
    }

    /**
     Read the current status for user configuration
     
     
     */
    func readCurrentLocationStatus(){
        let user = PFUser.currentUser()
        if((user?.valueForKey("isTracked"))! as! NSObject == 1){
            self.switchLocation.setOn(true, animated: false)
        }else{
            self.switchLocation.setOn(false, animated: false)
        }
    }
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
