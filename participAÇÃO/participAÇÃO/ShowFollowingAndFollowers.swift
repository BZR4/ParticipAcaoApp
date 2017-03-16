//
//  ShowFollowingAndFollowers.swift
//  ParticipACAO
//
//  Created by Rodrigo A E Miyashiro on 1/12/16.
//  Copyright © 2016 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import Parse

class ShowFollowingAndFollowers: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewFollowingFollowers: UITableView!
    
    
    var users: [PFObject] = []
    var allUsers: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        for user in users {
            if let userPhoto = user["picture_profile"] as? PFFile {
                userPhoto.getDataInBackgroundWithBlock({ (photo: NSData?, error: NSError?) -> Void in
                    
                    let newUser = User(userName: user["username"] as! String, userImg: photo!)
                    self.allUsers.append(newUser)
                    self.tableViewFollowingFollowers.reloadData()
                })
            }
            else {
                let newUser = User(userName: user["username"] as! String, userImg: UIImagePNGRepresentation(UIImage(named: "Circled User Male Filled-100.png")!)!)
                self.allUsers.append(newUser)
            }
        }
    }
    
    
    // MARKS: - TableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUsers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "followingAndFollowersCell"
        let cell = self.tableViewFollowingFollowers.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! ShowFollowingFollowersCell
        
        
        let followRow = self.allUsers[indexPath.row]
        
        
        cell.lblUserName.text = followRow.userName
        cell.imgUser.image = UIImage(data: followRow.userImg!)
        
        
        
        // Config Cell
        configImgUser(cell)
        
        // Test
        //        cell.imgUser.image = UIImage(named: "paisagem_urbana.jpg")
        //        cell.lblUserName.text = "Nome usuário"
        //        cell.lblAddress.text = "Av. Alan Turing, 275 - Barão Geraldo,Campinas - SP"
        //        cell.lblFollowers.text = "123 Seguidores"
        //        cell.lblFollowing.text = "123 Seguindo"
        
        
        return cell
    }
    
    
    
    func configImgUser (cell: ShowFollowingFollowersCell) {
        cell.imgUser.layer.masksToBounds = true
        cell.imgUser.layer.cornerRadius = cell.imgUser.layer.frame.size.width/2
        cell.imgUser.layer.borderWidth = 0.5
        cell.imgUser.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    
    // MARK: - TableView Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableViewFollowingFollowers.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    
    
}