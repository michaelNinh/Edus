//
//  ReplyPostTableViewCell.swift
//  Edus
//
//  Created by michael ninh on 11/13/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import UIKit
import DateTools
import Parse

protocol ShowFlagAlertForReplyPost{
    func showFlagAlert(title: String, message: String, callbackViewCell: ReplyPostTableViewCell)
    func showDeleteAlert(title: String, message: String, callbackViewCell: ReplyPostTableViewCell)
}

class ReplyPostTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var postContentText: UILabel!
    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    
    @IBAction func deletePost(sender: AnyObject) {
        delegate?.showDeleteAlert("", message: "Delete post?", callbackViewCell: self)
    }
    
    @IBAction func flagPost(sender: AnyObject) {
        delegate?.showFlagAlert("", message: "Flag for inappropriate content?", callbackViewCell: self)
        
    }
    
    @IBOutlet weak var upVoteButton: UIButton!
    @IBAction func upVote(sender: AnyObject) {
        replyPostsPoints.toReplyPost = self.replyPost
        replyPostsPoints.upVote()
        self.upVoteButton.enabled = false
        scoreText.text = String(Int(scoreText.text!)!+1)
    }
    
    var delegate: ShowFlagAlertForReplyPost?
    var replyPostsPoints = ReplyPostPoints()
    
    var replyPost: ReplyPost?{
        didSet{
            if let replyPost = replyPost{
                dateText.text = replyPost.createdAt?.shortTimeAgoSinceDate(NSDate()) ?? ""
                postContentText.text = replyPost.content
                nameText.text = replyPost.fromUserName
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
    
    func flagContentAction(){
        let postFlagger = ReplyPostFlag()
        postFlagger.toReplyPost = self.replyPost
        postFlagger.fromUser = PFUser.currentUser()
        postFlagger.toUser = self.replyPost?.fromUser
        postFlagger.flagContent()
    }
    
    func deleteContentAction(){
        self.replyPost!.deleteReplyPost()
    }

}
