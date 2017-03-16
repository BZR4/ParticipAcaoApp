//
//  RowZeroTableViewCell.swift
//  ParticipACAO
//
//  Created by Esdras Bezerra da Silva on 27/11/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit

class RowZeroTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgUserPost: UIImageView!
    @IBOutlet weak var lblNameUserPost: UILabel!  
    @IBOutlet weak var extraData: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
