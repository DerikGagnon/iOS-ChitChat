//
//  MessageCell.swift
//  ChitChat
//
//  Created by Gagnon, Derik on 4/19/18.
//  Copyright © 2018 Gagnon, Derik. All rights reserved.
//

import UIKit

class MessageCell : UITableViewCell {
 
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var dislikes: UIButton!
    
    
    @IBAction func likeButton(_ sender: UIButton) {
        //Make request to like post
        //Add post ID to like database
    }
    
    @IBAction func dislikeButton(_ sender: UIButton) {
        //Make request to dislike post
        //Add post ID to dislike database
    }
    
    var cell: Message? {
        didSet {
            guard let cell = cell else {
                return
            }
            self.message?.text = cell.message
            self.date?.text = cell.date
            self.likes?.text = cell.likes
            self.dislikes?.text = cell.dislikes
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
