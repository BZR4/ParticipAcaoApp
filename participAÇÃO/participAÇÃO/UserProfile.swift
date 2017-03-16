//
//  UserProfile.swift
//  ParticipACAO
//
//  Created by Rodrigo A E Miyashiro on 1/4/16.
//  Copyright © 2016 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import Parse

class UserProfile: UIViewController, UITableViewDataSource {
    
    // MARK: - IBAction's
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnCountFollowing: UIButton!
    @IBOutlet weak var btnCountFollowers: UIButton!
    @IBOutlet weak var btnEditeProfile: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableViewToPostActionsLike: UITableView!
    
    @IBOutlet weak var lblCountFollowers: UILabel!
    
    @IBOutlet weak var lblCountFollowing: UILabel!
    
    var userCity: String!
    var aboutMe: String!
    
    // MARK: - Variables and Constants
    var allFeedsThisUser: [PFObject] = []
    var allActionsFromThisUser:[PFObject] = []
    
    
    // Following
    var followings: [PFUser] = []
    var allUsersFollowings: [PFObject] = []
    var countFollowings: Int!
    // Followers
    var followers: [PFUser] = []
    var allUsersFollowers: [PFObject] = []
    var countFollowers: Int!

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configButtonsAndLabels()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadingUserInfo()

        getAllFeedFromThisUser ()
    }
    
    
    // MARK: - Utils - Configurate Buttons and Labels
    func configButtonsAndLabels () {
//        self.btnEditeProfile.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
//        self.btnEditeProfile.layer.cornerRadius = 5.0
        
//        self.userImage.layer.masksToBounds = true
//        self.userImage.layer.cornerRadius = 50.0
    }
    
    
    func loadingUserInfo () {
        
        PFUser.currentUser()?.fetchInBackgroundWithBlock({ (user: PFObject?, error: NSError?) -> Void in
            if error == nil {
                if let userPicture = user!["picture_profile"] as? PFFile {
                    userPicture.getDataInBackgroundWithBlock({ (dataImgUser: NSData?, error: NSError?) -> Void in
                        if error == nil {
                            let img = UIImage(data: dataImgUser!)
                            self.userImage.image = img
                        }
                    })
                }
                //                self.followings.removeAll()
                self.lblUserName.text = user!["username"] as? String
                
                self.userCity = user!["additional"] as? String
                self.aboutMe = user!["aboutMe"]     as? String
                // Followings
                if let followingsNotNil = (user!["following"] as? [PFUser]) {
                    self.followings = followingsNotNil
                    self.countFollowings = self.followings.count
                    self.lblCountFollowing.text = "\(self.countFollowings)"
                }
                
                // Followers
                if let followersNotNil = (user!["follower"] as? [PFUser]) {
                    self.followers = followersNotNil
                    self.countFollowings = self.followers.count
                    self.lblCountFollowers.text = "\(self.followers.count)"
                }
                
                
                self.allUsersFollowings.removeAll()
                self.allUsersFollowers.removeAll()
                
                for anUserFollowing in self.followings {
                    self.getFollowings(anUserFollowing)
                }
                
                for anUserFollower in self.followers {
                    self.getFollowers(anUserFollower)
                }
            }
        })
        
    }
    
    
    // Followings
    func getFollowings (userFollowing: PFUser) {
        
        let userFollowingQuery = PFUser.query()
        userFollowingQuery?.getObjectInBackgroundWithId(userFollowing.objectId!, block: { (user: PFObject?, error: NSError?) -> Void in
            if error == nil {
                self.allUsersFollowings.append(user!)
            }
            else {
                //TODO: - CORRIGIR ESSE PROBLEMA
                print("Error (getFollowing): \(error)")
            }
        })
        
    }
    
    // Followers
    func getFollowers (userFollower: PFUser) {
        let userFollowerQuery = PFUser.query()
        userFollowerQuery?.getObjectInBackgroundWithId(userFollower.objectId!, block: { (user: PFObject?, error: NSError?) -> Void in
            if error == nil {
                self.allUsersFollowers.append(user!)
            }
            else {
                //
                print("Error (getFollowers): \(error)")
            }
        })
    }

    
    
    
    
    // MARK: - IBAction
    @IBAction func selectOptionsFeed(sender: AnyObject) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            getAllFeedFromThisUser()
            break
            
        case 1:
            getAllFeedsAppliedAnAction()
            print("Ações")
            break
            
        case 2:
            getAllFeedsLiked()
            print("Apoio")
            break
            
        default:
            print("Error...")
        }
    }
    
    
    
    // MARK: - TableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allFeedsThisUser.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "cellPostActionsLike"
        let cell = self.tableViewToPostActionsLike.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! FeedCell
        
        let aFeed = self.allFeedsThisUser[indexPath.row]
        
//        cell.lblTitlePost.text = aFeed["subject"] as? String
        
        // CASO NAO TENHA IMAGEM, NAO ENTRA NESTE METODO...
        if let userPicture = aFeed.valueForKey("user")?.valueForKey("picture_profile") as? PFFile {
            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error:NSError?) -> Void in
                if error == nil {
                    
                    if(self.segmentedControl.selectedSegmentIndex == 0){
                        let image = UIImage(data: imageData!)
                        cell.imgUser.layer.masksToBounds = true
                        cell.imgUser.layer.cornerRadius = cell.imgUser.layer.frame.size.width/2
                        cell.imgUser.image = image
                        //it's possible to manipute a PFUser element embeed into Topic
                        cell.lblNameUser.text = aFeed.valueForKey("user")?.objectForKey("username") as? String
                        cell.lblDatePost.text = aFeed.valueForKey("category")?.objectForKey("category") as? String
                        cell.lblTitlePost.text = aFeed.valueForKey("subject") as? String

                    }else if (self.segmentedControl.selectedSegmentIndex == 1){
                        
                        let image = UIImage(data: imageData!)
                        cell.imgUser.layer.masksToBounds = true
                        cell.imgUser.layer.cornerRadius = cell.imgUser.layer.frame.size.width/2
                        cell.imgUser.image = image
                        //it's possible to manipute a PFUser element embeed into Topic
                        cell.lblNameUser.text = aFeed.valueForKey("user")?.objectForKey("username") as? String
                        cell.lblDatePost.text = aFeed.valueForKey("category")?.objectForKey("category") as? String
                        cell.lblTitlePost.text = aFeed.valueForKey("content") as? String

                    }
                    
                    
                    // spinner temp
//                    self.spinnerTemp.stopAnimating()
//                    self.spinnerTemp.hidden = true
                    
                }else{
                    print("Error: \(error)")
                }
            }
        }
        
        return cell
    }
    
    // MARK: - Data Used in tableView
    //Get all feeds this user published
    func getAllFeedFromThisUser () {
        
        self.allFeedsThisUser.removeAll()
        
        let currentUser = PFUser.currentUser()
        let query = PFQuery(className: "Topic")
        query.includeKey("user")
        query.includeKey("category")
        query.orderByDescending("createAt")
        query.whereKey("user", equalTo: currentUser!)
        
        query.findObjectsInBackgroundWithBlock { (result: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                self.allFeedsThisUser = result!
                self.tableViewToPostActionsLike.reloadData()
            }
            else {
                print("ERROR: \(error)")
            }
        }
        
    }
    
    // Get all feeds applied an action
    // CORRIGIR METODO (PEGAR APENAS OS FEEDS QUE O USUARIO PUBLICOU UMA AÇÃO)
    func getAllFeedsAppliedAnAction () {
        
        self.allFeedsThisUser.removeAll()

        let currentUser = PFUser.currentUser()
//        
//        let queryTopic = PFQuery(className: "Topic")
//        let queryReply = PFQuery(className: "Replay")
//        queryReply.whereKey("user", equalTo: currentUser!)
//        queryTopic.whereKey("objectId", matchesKey: "topic", inQuery: queryReply)
//        queryTopic.findObjectsInBackgroundWithBlock { (topics: [PFObject]?, error: NSError?) -> Void in
//            if error == nil {
//                print("Topics: \(topics)")
//            }
//            else {
//                print("Error: \(error)")
//            }
//        }
        
        let replyQuery = PFQuery(className: "Reply")
        replyQuery.whereKey("user", equalTo: currentUser!)
        replyQuery.whereKey("isAction", equalTo: true)
        replyQuery.includeKey("topic")
        replyQuery.includeKey("user")
        replyQuery.findObjectsInBackgroundWithBlock { (result:[PFObject]?, error:NSError?) -> Void in
            if error == nil {
                print("query result \(result)")
                self.allFeedsThisUser = result!
                self.tableViewToPostActionsLike.reloadData()

            }else{
                print("Deu ruim")
            }
        }
    }
    
    
    // Get all feed liked
    // (PEGAR APENAS OS FEEDS QUE O USUARIO DEU LIKE)
    func getAllFeedsLiked () {
        
    }
    
    
    // MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "followingSegue" {
            let showFollowing = segue.destinationViewController as? ShowFollowingAndFollowers
            showFollowing!.users = self.allUsersFollowings 
        }
        if segue.identifier == "followerSegue" {
            let showFollower = segue.destinationViewController as? ShowFollowingAndFollowers
            showFollower!.users = self.allUsersFollowers
        }
        
        if segue.identifier == "profileEditSegue" {
            let profileEdit = segue.destinationViewController as? PerfilViewController
            profileEdit?.userName               = self.lblUserName.text
            profileEdit?.imageSelected          = userImage.image
            profileEdit?.city                   = self.userCity
            profileEdit?.aboutMe                = self.aboutMe
            
        }
        
        
    }
    
    
    
}