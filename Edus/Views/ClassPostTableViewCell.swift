//
//  ClassPostTableViewCell.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit

class ClassPostTableViewCell: UITableViewCell {
    
    var post: Post?{
        didSet{
            if let post = post{
                
            }
        }
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
