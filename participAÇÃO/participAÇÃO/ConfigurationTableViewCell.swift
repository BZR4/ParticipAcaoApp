//
//  ConfigurationTableViewCell.swift
//  ParticipACAO
//
//  Created by Esdras Bezerra da Silva on 20/01/16.
//  Copyright © 2016 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit

class ConfigurationTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var imageConfig: UIImageView!
    @IBOutlet weak var labelConfig: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
