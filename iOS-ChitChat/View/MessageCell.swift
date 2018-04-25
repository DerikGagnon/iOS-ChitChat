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
    @IBOutlet weak var dislikes: UILabel!
    
    var messageItem: Message!
    
    
    @IBAction func likeButton(_ sender: UIButton) {
        //Make request to like post
        let text = likes.text   // converting the labels display to a string value
        let numberFormatter = NumberFormatter()
            
        let theNumber = numberFormatter.number(from: text!)?.intValue // the number is assigned the value of 100.5
        messageItem?.like()
        likes.text = String(theNumber! + 1)
    }
    
    @IBAction func dislikeButton(_ sender: UIButton) {
        //Make request to dislike post
        let text = dislikes.text   // converting the labels display to a string value
        let numberFormatter = NumberFormatter()
            
        let theNumber = numberFormatter.number(from: text!)?.intValue // the number is assigned the value of 100.5
        messageItem?.dislike()
        dislikes.text = String(theNumber! + 1)
    }
    
    var cell: Message? {
        didSet {
            guard let cell = cell else {
                return
            }
            self.message?.text = cell.message
            self.date?.text = cell.date
            self.likes?.text = String(cell.likes)
            self.dislikes?.text = String(cell.dislikes)
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
