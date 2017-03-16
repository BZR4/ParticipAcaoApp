//
//  FeedCell.swift
//  participAÇÃO
//
//  Created by Rodrigo A E Miyashiro on 10/14/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    // MARK: - IBAction's
    // User
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblNameUser: UILabel!
    
    // Post
    @IBOutlet weak var lblDatePost: UILabel!
    @IBOutlet weak var lblTitlePost: UILabel!
    @IBOutlet weak var imgSolution: UIImageView!
    @IBOutlet weak var lblSolutionCount: UILabel!
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var imgComment: UIView!
    @IBOutlet weak var lblCommentCount: UILabel!
    
    @IBOutlet weak var tagImageView: UIImageView!

    
    // Buttons
    @IBOutlet weak var btnComment: UIView!
    
    
}
