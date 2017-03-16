//
//  FeedViewController.swift
//  participAÇÃO
//
//  Created by Rodrigo A E Miyashiro on 10/14/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import Parse
import Social
import ParseFacebookUtilsV4
import FBSDKShareKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    // MARK: - Variables and Constants
    var feeds: [Feed] = []

    // MARK: - IBOutlets
    @IBOutlet weak var inputTextOnItemBar: UIBarButtonItem!
    
    @IBOutlet weak var teste: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var shareButton: UIButton!
    
    // ActivityIndicator (Temporary)
    @IBOutlet weak var spinnerTemp: UIActivityIndicatorView!
    
    @IBOutlet weak var feedTableView: UITableView!
    
    @IBAction func testInputTextOnItemBar(sender: AnyObject) {
        print("Text On textField on ToolBar", self.teste.text)
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.feedTableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        self.feedTableView.tableFooterView = UIView(frame: CGRectZero)
        self.feedTableView.separatorColor = UIColor(red:210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 0.9)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.queryPostData()

        feedTableView.estimatedRowHeight = 150
        feedTableView.rowHeight = UITableViewAutomaticDimension
        
        
        // spinner temp
        self.spinnerTemp.hidden = false
        self.spinnerTemp.startAnimating()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
//        deregisterFromKeyboardNotifications()
//        theImageView.tintColor = UIColor.redColor()
    }
    
    // MARK: - TableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feeds.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "feedCell"
        
        let cell = self.feedTableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! FeedCell
        

        
        
        cell.backgroundColor = UIColor.clearColor()
        
        
        let aFeed = self.feeds[indexPath.row]
        
        // Config Cell
        configCell(cell)
        //  Mudar a cora da Tag
        cell.tagImageView.tintColor = UIColor(red: 78.0/255, green: 207.0/255.0, blue: 174.0/255.0, alpha: 1)

        
        // Thread
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            
            var userImage: UIImage!
            userImage = UIImage(data: (aFeed.userPost?.userImg)!)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                cell.imgUser.image = userImage
            })
        })
        
        cell.lblNameUser.text = (aFeed.userPost?.userName)!
        cell.lblTitlePost.text = aFeed.titlePost
        
        
        
        
//        cell.imgUser.image = UIImage(named: "contacts.png")
//        cell.lblNameUser.text = "Fulano"
//        cell.lblTitlePost.text = "Como está apresentando o título??"
        
        return cell
    }
    
    
    func configCell (cell: FeedCell) {
        
        //cells config
        
        cell.imgUser.layer.masksToBounds = true
        cell.imgUser.layer.cornerRadius = cell.imgUser.layer.frame.size.width/2
        cell.imgUser.layer.borderWidth = 0.5
        cell.imgUser.layer.borderColor = UIColor.whiteColor().CGColor
        
        cell.imgSolution.layer.masksToBounds = true
//        cell.imgSolution.layer.cornerRadius = cell.imgSolution.layer.frame.size.width/2
//        cell.imgSolution.layer.borderWidth = 0.3
//        cell.imgSolution.layer.borderColor = UIColor.grayColor().CGColor
//        cell.imgSolution.layer.backgroundColor = UIColor.lightGrayColor().CGColor
        
        cell.imgLike.layer.masksToBounds = true
//        cell.imgLike.layer.cornerRadius = cell.imgLike.layer.frame.size.width/2
//        cell.imgLike.layer.borderWidth = 0.3
//        cell.imgLike.layer.borderColor = UIColor.grayColor().CGColor
//        cell.imgLike.layer.backgroundColor = UIColor.lightGrayColor().CGColor
        
        cell.imgComment.layer.masksToBounds = true
//        cell.imgComment.layer.cornerRadius = cell.imgComment.layer.frame.size.width/2
//        cell.imgComment.layer.borderWidth = 0.3
//        cell.imgComment.layer.borderColor = UIColor.grayColor().CGColor
//        cell.imgComment.layer.backgroundColor = UIColor.lightGrayColor().CGColor
        
    }
    
    // MARK: - TableView Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        let aFeed = self.allFeeds[indexPath.row]
//        self.content?.contentDescription = aFeed["subject"] as? String
//        self.content?.contentTitle = "Teste"
//        self.content?.contentURL = NSURL(string: "http://google.com")
//        print("O content é \(self.content)")
    }
    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        let rotationAngleInRadians = 90.0 * CGFloat(M_PI/180.0);
//        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -300, 100, 0)
//        cell.layer.transform = rotationTransform;
//        cell.alpha = 0.0
//        
//        UIView.animateWithDuration(1.0, animations: { /*cell.layer.transform = CATransform3DIdentity*/cell.alpha = 1 })
//    }
    
    
    // MARK - Query from backend database
    
    func queryPostData() {
        let innerQuery = PFQuery(className: "Topic")
        innerQuery.includeKey("user")
        innerQuery.includeKey("category")
        
        innerQuery.orderByDescending("createdAt")
        
//        innerQuery.limit = 10
        
        innerQuery.cachePolicy = .NetworkElseCache

        innerQuery.findObjectsInBackgroundWithBlock { (result:[PFObject]?, error:NSError?) -> Void in
           
            if(error == nil){
                
                self.createFeedsObject(result!)
                
            }else{
                print("it was impossible to find the objects")
            }
        }
    }
    
    func createFeedsObject (results: [PFObject]) {
        self.feeds.removeAll()
        for result in results {

            if let userPicture = result["user"]["picture_profile"] as? PFFile {
                userPicture.getDataInBackgroundWithBlock({ (image: NSData?, error: NSError?) -> Void in
                    
                    let user = User(userName: (result["user"]["username"] as? String)!,
                                     userImg: image!)
                    
                    let category = Categories(imgCategory: "",
                                            titleCategory: (result["category"]["category"] as? String)!,
                                      categoryDescription: (result["category"]["categoryDescription"] as? String)!)

                    //TODO: - Inserir data
                    let newFeed = Feed(userName: user.userName!,
                                        userImg: user.userImg!,
                                    imgCategory: category.imgCaterory!,
                                  titleCategory: category.titleCategory!,
                            categoryDescription: category.categoryDescription!,
                                       datePost: NSDate(),
                                      titlePost: (result["subject"] as? String)!,
                                       objectID: result.objectId!)
                    
                    self.feeds.append(newFeed)
                    self.feedTableView.reloadData()
                })
            }
        
        }
        // spinner temp
        self.spinnerTemp.stopAnimating()
        self.spinnerTemp.hidden = true
    }
    
    // MARK: - Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueContainer" {
            let destinationViewController = segue.destinationViewController as? FeedDetails
            let selectedIndex = self.feedTableView.indexPathForSelectedRow
            print("Index: ",selectedIndex)
            // TODO: - Mudar!!!!!
            let currentTopic = self.feeds[(selectedIndex?.row)!].objectID!
            print("Topic ID: ",currentTopic)
            destinationViewController?.topicId = currentTopic as String
        }
    }
    
}
