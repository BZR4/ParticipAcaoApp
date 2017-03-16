//
//  DetailFeedViewController.swift
//  ParticipACAO
//
//  Created by Esdras Bezerra da Silva on 30/01/16.
//  Copyright © 2016 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import Parse
import FBSDKMessengerShareKit
import FBSDKShareKit
import TwitterKit


class DetailFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ActionsInCellTwoDelegate, likeFromCellProtocol {
    
    // Mark: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var replyTextField: UITextField!
    
    @IBOutlet weak var testView: UIView!
    
    @IBOutlet weak var effectView: UIVisualEffectView!
    
    @IBOutlet weak var actionButton: UIBarButtonItem!
    
    @IBOutlet weak var actionTextField: UITextView!
    
    @IBOutlet weak var titleForAction: UILabel!
    
    @IBOutlet weak var toolBar: UIToolbar!

    // Mark - SPINNER TEMP
    @IBOutlet weak var spinnerTempFeedDetails: UIActivityIndicatorView!
    
    // MARK: - Variables and Constants
    var parseConteiner = [PFObject]()
    var conteiner = [String]()
    var user = [String]()
    var topicId = ""
    var imageUserForAction: UIImage?
    var isAction: Bool! = false
    var actionViewIsVisible: Bool! = false
    let shareButton = FBSDKShareButton()
  
    // Mark: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let tapTable = UIGestureRecognizer(target: self, action: "keyboardWillBeHidden")
        
//        self.tableView.addGestureRecognizer(tapTable)
        
        let tapView = UITapGestureRecognizer(target: self, action: "dismissKeyBoard")
        
//        self.view.addGestureRecognizer(tapView)
        
        let tapEffectView = UITapGestureRecognizer(target: self, action: "dismissActionView")
//        self.effectView.addGestureRecognizer(tapEffectView)
        
        //        let tap = UITapGestureRecognizer(target: self, action: "share")
        //        self.view.addGestureRecognizer(tap)

        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidAppear(animated)
        
        deregisterFromKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: - TableView Delegate methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row: \(indexPath.row)")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("zero", forIndexPath: indexPath) as! RowZeroTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("one", forIndexPath: indexPath) as! RowOneTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("two", forIndexPath: indexPath) as! RowTwoTableViewCell
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("three", forIndexPath: indexPath) as! RowThreeTableViewCell
            cell.delegate = self
            return cell
        }
    }
    
    // Mark: - Protocol for Actions in Cell
    func likeFromCell(cell: RowTwoTableViewCell, sender: AnyObject) {
        print("I like it!")
    }
    
    func solutionFromCell(cell: RowTwoTableViewCell, sender: AnyObject) {
        print("I am the solution!")
    }
    
    func likeFromCellThree(cell: RowThreeTableViewCell, sender: AnyObject) {
        print("Like from Cell Three!")
    }
    
    // MARK: - Load data on Parse
    
    // MARK: - keyboard methods
    func registerForKeyboardNotifications()
    {
        //Adding notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications()
    {
        //Removing notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification)
    {
        //geting the information of user
        let userInfo: [NSObject : AnyObject] = notification.userInfo!
        
        //get the size of the keyboard
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        
        //get the size of the screen with the keyboard shown
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        
        //compare if the heights are equals
        if keyboardSize.height == offset.height {
            if self.view.frame.origin.y == 0 {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.view.frame.origin.y -= keyboardSize.height - self.toolBar.frame.height - 5
                })
            }
        } else {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y += keyboardSize.height - offset.height
            })
        }
        
        
    }
    
    
    func keyboardWillBeHidden(notification: NSNotification)
    {
        //Return the frame to original position
        let userInfo: [NSObject : AnyObject] = notification.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        self.view.frame.origin.y += keyboardSize.height - self.toolBar.frame.height - 5
        
        
    }
    
    
    func dismissKeyBoard(){
        view.endEditing(true)
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

