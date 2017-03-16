//
//  RowTwoTableViewCell.swift
//  ParticipACAO
//
//  Created by Esdras Bezerra da Silva on 27/11/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit

protocol ActionsInCellTwoDelegate: class{
    func likeFromCell(cell: RowTwoTableViewCell, sender: AnyObject)
    func solutionFromCell(cell: RowTwoTableViewCell, sender: AnyObject)
}

class RowTwoTableViewCell: UITableViewCell {
    
    weak var delegate: ActionsInCellTwoDelegate?
    
    @IBOutlet weak var btnLikePost: UIButton!
    @IBOutlet weak var counterLikes: UILabel!
    @IBOutlet weak var iconSolutionFilter: UIButton!
    @IBOutlet weak var counterSolutions: UILabel!
    @IBOutlet weak var buttonCountReply: UIButton!
    @IBOutlet weak var counterReply: UILabel!
    

    @IBAction func likeFromCell(sender: AnyObject) {
        self.delegate?.likeFromCell(self, sender: sender)
    }

    @IBAction func solutionFromCell(sender: AnyObject) {
        self.delegate?.solutionFromCell(self, sender: sender)
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
