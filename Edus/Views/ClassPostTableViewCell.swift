//
//  ClassPostTableViewCell.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import DateTools

class ClassPostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postTitleText: UILabel!
    @IBOutlet weak var postContentText: UILabel!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var scoreText: UILabel!
    
    
    @IBAction func upVote(sender: AnyObject) {
    }
    
    
    @IBAction func deletePost(sender: AnyObject) {
    }
    
    
    @IBAction func flagPost(sender: AnyObject) {
    }
    
    var post: Post?{
        didSet{
            if let post = post{
                dateText.text = post.createdAt?.shortTimeAgoSinceDate(NSDate()) ?? ""
                postTitleText.text = post.title
                postContentText.text = post.content
                nameText.text = post.fromUserName
                scoreText.text = String(post.toPostPoints.score)
                
                print("FUCK\(self.nameText)")
            }else{
                print("no post")
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
