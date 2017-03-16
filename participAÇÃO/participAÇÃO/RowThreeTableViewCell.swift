//
//  RowThreeTableViewCell.swift
//  ParticipACAO
//
//  Created by Esdras Bezerra da Silva on 15/01/16.
//  Copyright © 2016 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit

protocol likeFromCellProtocol: class{
    func likeFromCellThree(cell: RowThreeTableViewCell, sender: AnyObject)
}

class RowThreeTableViewCell: UITableViewCell {
    
    weak var delegate: likeFromCellProtocol?
    
    @IBOutlet weak var imageUserReply: UIImageView!
    @IBOutlet weak var textReply: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func likeFromCellThree(sender: AnyObject) {
        self.delegate?.likeFromCellThree(self, sender: sender)
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
