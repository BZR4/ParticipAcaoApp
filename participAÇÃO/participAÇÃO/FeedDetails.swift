//
//  FeedDetails.swift
//  participAÇÃO
//
//  Created by Rodrigo A E Miyashiro on 11/4/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import Parse
import FBSDKMessengerShareKit
import FBSDKShareKit
import TwitterKit


class FeedDetails: UIViewController, UITableViewDataSource, UITableViewDelegate, ActionsInCellTwoDelegate {
    
    // MARK: - IBOutlet's
    @IBOutlet weak var tableViewFeedDetails: UITableView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var replyTextField: UITextField!
    
    @IBOutlet weak var testView: UIView!
    
    @IBOutlet weak var effectView: UIVisualEffectView!
    
    @IBOutlet weak var actionButton: UIBarButtonItem!
    
    @IBOutlet weak var actionTextField: UITextView!
    
    @IBOutlet weak var actionUser: UIImageView!
    
    @IBOutlet weak var topicForAction: UILabel!
    
    @IBOutlet weak var imageForAction: UIImageView!
    
    @IBOutlet weak var imageAlignX: NSLayoutConstraint!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var titleForAction: UILabel!
    
    
    // Mark - SPINNER TEMP
    @IBOutlet weak var spinnerTempFeedDetails: UIActivityIndicatorView!
    
    @IBOutlet weak var toolBar: UIToolbar!
    // MARK: - Variables and Constants
    var parseConteiner = [PFObject]()
    var conteiner = [String]()
    var user = [String]()
    var topicId = ""
    var imageUserForAction: UIImage?
    var isAction: Bool! = false
    var actionViewIsVisible: Bool! = false
    let shareButton = FBSDKShareButton()
    
    // MARK: - Protocol Cell
    
    func likeFromCell(cell: RowTwoTableViewCell, sender: AnyObject) {
        print("I Like It!")
//        self.tableViewFeedDetails.reloadData()
    }
    
    func solutionFromCell(cell: RowTwoTableViewCell, sender: AnyObject) {
        print("I am the solution!")
//        self.tableViewFeedDetails.reloadData()
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.hidesBarsOnSwipe = false
        
        self.tableViewFeedDetails.estimatedRowHeight = 44
        self.tableViewFeedDetails.rowHeight = UITableViewAutomaticDimension
        
//        let tapTable = UIGestureRecognizer(target: self, action: "keyboardWillBeHidden")
//        
//        self.tableViewFeedDetails.addGestureRecognizer(tapTable)
//
//        
//        let tapView = UITapGestureRecognizer(target: self, action: "dismissKeyBoard")
//        
//        self.view.addGestureRecognizer(tapView)
        
        let tapEffectView = UITapGestureRecognizer(target: self, action: "dismissActionView")
        self.effectView.addGestureRecognizer(tapEffectView)
        
//        let tap = UITapGestureRecognizer(target: self, action: "share")
//        self.view.addGestureRecognizer(tap)


    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.navigationController?.hidesBarsOnSwipe = false
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        // SPINER TEMP
//        self.spinnerTempFeedDetails.hidden = false
//        self.spinnerTempFeedDetails.startAnimating()
        
        
        self.loadDataOnParse()
        
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidAppear(animated)
        
        deregisterFromKeyboardNotifications()
    }
    
    
    // MARK: - TableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.parseConteiner.count
        return 6
    }
    //  sizeThatFit -> Label
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        switch indexPath.row {
        case 0:
            let cellZero = tableView.dequeueReusableCellWithIdentifier("zero", forIndexPath: indexPath) as! RowZeroTableViewCell
            return cellZero
        case 1:
            let cellOne = tableView.dequeueReusableCellWithIdentifier("one", forIndexPath: indexPath) as! RowOneTableViewCell
            return cellOne
        case 2:
            let cellTwo = tableView.dequeueReusableCellWithIdentifier("two", forIndexPath: indexPath) as! RowTwoTableViewCell
            
//            cellTwo.btnLikePost.addTarget(self,         action: "actionButtonLike:",        forControlEvents: UIControlEvents.TouchUpInside)
//            cellTwo.iconSolutionFilter.addTarget(self,  action: "actionButtonSolutions:",   forControlEvents: UIControlEvents.TouchUpInside)
//            cellTwo.buttonCountReply.addTarget(self,    action: "actionButtonComments:",    forControlEvents: UIControlEvents.TouchUpInside)
            cellTwo.delegate = self
            
            return cellTwo
            
        default:
            let participacao = tableView.dequeueReusableCellWithIdentifier("three", forIndexPath: indexPath) as! RowThreeTableViewCell
            
            participacao.textReply.text = "By theme definitions I mean the color, font, shadow, and other settings for different UI elements. If you worked with web apps before, such things would be commonly stored in the CSS file."
            
            return participacao
            
            
        }
    }
    
    // MARK: - Actions Buttons
    func actionButtonLike (sender: UIButton!) {
       print("Likes")
    }
    
    func actionButtonSolutions (sender: UIButton!) {
        print("Solutions")
    }
    
    func actionButtonComments (sender: UIButton!) {
        print("Comments")
    }
    
    
    // MARK: - Config Cells
    // Full line width on tableView Cell
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // Full
        if indexPath.row == 0 || indexPath.row == 1 {
            // Removendo forçado...
            cell.separatorInset.left = 1000.0
            cell.layoutMargins.left = 1000.0
        }
        else if indexPath.row == 2 {
            // Retira das duas bordas
            cell.separatorInset.right = 15.0
            cell.layoutMargins.right = 15.0
        }
        else {
            cell.separatorInset = UIEdgeInsetsZero
            cell.layoutMargins = UIEdgeInsetsZero
        }
        
    }
    
    //
    func configImgPost (cell: FeedDetailCell) {
//        cell.imgPost.layer.masksToBounds = false
//        cell.imgPost.layer.shadowColor = UIColor.grayColor().CGColor
//        cell.imgPost.layer.borderWidth = 5.0
//        cell.imgPost.layer.borderColor = UIColor.whiteColor().CGColor
//        cell.imgPost.layer.shadowOffset = CGSizeMake(2.0, 2.0)
//        cell.imgPost.layer.shadowOpacity = 0.7
//        cell.imgPost.layer.cornerRadius = 5.0
    }
    
    // Adjusting the height of each cell
    func configHeightCell (row: Int) {
        
        if row == 0 {
            self.tableViewFeedDetails.rowHeight = 80.0
        }
        else if row == 1 {
            self.tableViewFeedDetails.rowHeight = 220.0
        }
        else if row == 2 {
            self.tableViewFeedDetails.rowHeight = 44.0
        }
        else {
            self.tableViewFeedDetails.rowHeight = 120.0
        }
    }
    
    //
    func configHiddenCells (cell: FeedDetailCell, imgPost: Bool, btnSolution: Bool, btnLike: Bool, btnComment: Bool, btnMore: Bool, imgUserPost: Bool, lblNameUserPost: Bool, lblTextPost: Bool, lblDatePost: Bool, btnLikePost: Bool) {
        
        cell.imgPost.hidden = imgPost
        cell.btnSolution.hidden = btnSolution
        cell.btnLike.hidden = btnLike
        cell.btnComment.hidden = btnComment
        cell.btnMore.hidden = btnMore
        cell.imgUserPost.hidden = imgUserPost
        cell.lblNameUserPost.hidden = lblNameUserPost
        cell.lblTextPost.hidden = lblTextPost
        cell.lblDatePost.hidden = lblDatePost
        cell.btnLikePost.hidden = btnLikePost
    }
    
    
    // MARK: - Load data on Parse
    
    func loadDataOnParse(){
        
        self.parseConteiner.removeAll()
        
        let queryReply = PFQuery(className: "Reply")
        queryReply.whereKey("topic", equalTo: PFObject(outDataWithClassName: "Topic", objectId: self.topicId))
        queryReply.includeKey("user")
        queryReply.includeKey("topic")
        
        queryReply.orderByDescending("createdAt")

        queryReply.cachePolicy = .NetworkElseCache

        
        queryReply.findObjectsInBackgroundWithBlock { (result, error) -> Void in
            if error == nil {
                if let comments = result as [PFObject]?{
                    //  Título do tópico - estava sendo carregado na view de proposta de solução
//                    self.topicForAction.text = result?[0].valueForKey("topic")?.valueForKey("subject") as? String
                    for comment in comments {
                        self.parseConteiner.append(comment)
                        print("COMMENT: \(comment)")
                        print("replay: \(comment["content"] as! String)")
                        print("Topic: \(comment.valueForKey("topic")?.valueForKey("subject"))")
                        
                    }
                    
                    
                    // TODO: Arrumar essa porcaria!!!
                    // adicionado um "comment" na posição 1 apenas para dar espaço em uma linha na tabela
                    self.parseConteiner.insert(comments.last!, atIndex: 0)
                    self.parseConteiner.insert(comments[0], atIndex: 1)
                    self.parseConteiner.insert(comments[0], atIndex: 2)
                    self.parseConteiner.removeLast()
                    
                    self.tableViewFeedDetails.reloadData()
                }
            }
            else{
                print("Error Loading Reply data: ", error?.localizedDescription)
            }
        }
    }
    
    
    // TODO: Separar código para facilitar reutilização (analisar viabilidade)
    func getImagePost (currentTopic: PFObject) -> UIImage {
        var imagePost = UIImage()
        
        if let topic_picture = currentTopic["topic"]["image"] as? PFFile{
            topic_picture.getDataInBackgroundWithBlock({ (data, error) -> Void in
                if error == nil {
                    imagePost = UIImage(data: data!)!
                    
                }else{
                    imagePost = UIImage(named: "lake.jpg")!
                }
            })
        }
        return imagePost
    }
    
    
    
    func getImageUser (currentImgUser: PFObject) -> UIImage {
        var pictureProfile = UIImage()
        
        if let userImage = currentImgUser["user"]["picture_profile"] as? PFFile{
            userImage.getDataInBackgroundWithBlock({ (data , error) -> Void in
                if error == nil {
                    pictureProfile = UIImage(data: data!)!
                }else{
                    pictureProfile = UIImage(named: "robot.jpg")!
                }
            })
        }
        return pictureProfile
    }
    
    
    
    @IBAction func saveReply(sender: AnyObject) {
        if sender.tag == 1 && self.actionViewIsVisible == true {
            self.isAction = true
        }else{
            self.isAction = false
        }
        
        saveComment()
    }
    
    
    
    //  Tentar reutilizar os objetos do request anterior
    
    
    func saveComment() {
        
        let topicQuery = PFQuery(className: "Topic")
//        topicQuery.cachePolicy = .NetworkElseCache
        topicQuery.getObjectInBackgroundWithId(self.topicId){ (topic: PFObject?, error: NSError?) -> Void in
            if error == nil {
                print(topic)
                let reply = PFObject(className: "Reply")
                
                if (self.replyTextField.text!.isEmpty) {
                    
                }else{
                    if self.isAction == true {
                        reply["content"] = self.actionTextField.text
                    }else{
                        reply["content"] = self.replyTextField.text
                    }
                    
                    reply["user"] = PFUser.currentUser()
                    reply["topic"] = topic
                    reply["isAction"] = self.isAction
                    reply.saveInBackgroundWithBlock({ (success, error) -> Void in
                        if success == true {
                            print("Reply saved!")
                            self.loadDataOnParse()
                            self.tableView.reloadData()
                            self.replyTextField.text = ""
                            self.dismissKeyBoard()
                
                        }else{
                            print("Error saving reply: ",error?.userInfo)
                        }
                    })
                }
            }
        }
    }
    
    
    
    
    // MARK: - TableView Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row: ",indexPath.row)
    }
    
    
    
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
    
    
    @IBAction func callActionView(sender: AnyObject) {
        
        
        if self.actionViewIsVisible == false {
            self.actionViewIsVisible = true;
            self.isAction = true
            
            UIView.animateWithDuration(0.5) { () -> Void in
                self.effectView.alpha = 0.9
                self.effectView.hidden = false
            }
            
            self.testView.alpha = 0
            self.testView.hidden = false
            self.testView.transform = CGAffineTransformMakeTranslation(0, self.view.frame.height)
            UIView.animateWithDuration(0.5) { () -> Void in
                self.testView.alpha = 1
                self.testView.transform = CGAffineTransformMakeTranslation(0, self.view.frame.height * 0.04)
            }
        }else{
            
            if self.actionTextField.text != nil {
                saveComment()
                self.actionViewIsVisible = false
                dismissActionView()
            }else{
                print("Campo Reply vazio!")
            }
            
        }
        print("Action view is visible: \(self.actionViewIsVisible)")
        print("Is Action: \(self.isAction)")
    }
    
    func dismissActionView(){
        UIView.animateWithDuration(0.5) { () -> Void in
            
            self.testView.transform = CGAffineTransformMakeTranslation(0, self.view.frame.height)
        }
        UIView.animateWithDuration(0.6) { () -> Void in
            self.testView.alpha = 0
            self.effectView.alpha = 0
        }
        self.actionViewIsVisible = false
    }
    
    
    func share(title:String, description: String, url: String){
        
    }
    
    
    @IBAction func insertPictureOnAction(sender: AnyObject) {
        UIView.animateWithDuration(2) { () -> Void in
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.titleForAction.transform = CGAffineTransformMakeTranslation(-80, 0)
                self.imageForAction.alpha = 1
                let scale = CGAffineTransformMakeScale(1.4, 1.4)
                self.imageForAction.transform = scale
            })
        }
        
    }
}
