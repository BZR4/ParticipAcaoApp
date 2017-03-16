//
//  FeedDetailCell.swift
//  participAÇÃO
//
//  Created by Rodrigo A E Miyashiro on 11/4/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit

class FeedDetailCell: UITableViewCell {

    // MARK: - IBOutlet's
    
    // Imagem Post
    @IBOutlet weak var imgPost: UIImageView!
    
    
    // Button's
    @IBOutlet weak var btnSolution: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnMore: UIButton!
    
    
    // Post's
    @IBOutlet weak var imgUserPost: UIImageView!
    @IBOutlet weak var lblNameUserPost: UILabel!
    @IBOutlet weak var lblTextPost: UILabel!
    @IBOutlet weak var lblDatePost: UILabel!
    
    @IBOutlet weak var btnLikePost: UIButton!
    
    // SPINNER TEMP
    @IBOutlet weak var spinnerTemp: UIActivityIndicatorView!
}
