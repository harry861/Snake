//
//  RankTableViewCell.swift
//  
//
//  Created by AutumnCAT on 2018/6/27.
//

import UIKit

class RankTableViewCell: UITableViewCell {

    @IBOutlet weak var NOLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
