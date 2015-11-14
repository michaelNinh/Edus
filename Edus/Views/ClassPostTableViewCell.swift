//
//  ClassPostTableViewCell.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import DateTools
import Parse


class ClassPostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postTitleText: UILabel!
    @IBOutlet weak var postContentText: UILabel!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var scoreText: UILabel!
    
    
    @IBOutlet weak var upVoteButton: UIButton!
    @IBAction func upVote(sender: AnyObject) {
        postPoints.toPost = self.post
        postPoints.upVote()
        self.upVoteButton.enabled = false
    }
    
    
    @IBAction func deletePost(sender: AnyObject) {
    }
    
    
    @IBAction func flagPost(sender: AnyObject) {
    }
    
    var voterList = [String]()
    var postPoints = PostPoints()
    
    var post: Post?{
        didSet{
            if let post = post{
                dateText.text = post.createdAt?.shortTimeAgoSinceDate(NSDate()) ?? ""
                postTitleText.text = post.title
                postContentText.text = post.content
                nameText.text = post.fromUserName
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
