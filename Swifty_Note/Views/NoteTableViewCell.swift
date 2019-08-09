//
//  noteTableViewCell.swift
//  Swifty_Note
//
//  Created by user on 8/2/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class noteTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionTxt: UILabel!
    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var noteNumberTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
