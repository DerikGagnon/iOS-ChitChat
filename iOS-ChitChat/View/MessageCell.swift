//
//  MessageCell.swift
//  ChitChat
//
//  Created by Gagnon, Derik on 4/19/18.
//  Copyright © 2018 Gagnon, Derik. All rights reserved.
//

import UIKit

class MessageCell : UITableViewCell {
 
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dislikesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    
    var messageItem: Message!
    let defaults = UserDefaults.standard
    var isLiked:Array<String> = []
    var isDisliked:Array<String> = []
    
    func setMessage(message: Message) {
        self.messageItem = message
        messageLabel.text = message.message
        
        dateLabel.text = message.date
        likesLabel.text = String(message.likes)
        dislikesLabel.text = String(message.dislikes)
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
        //Make request to like post
        let text = likesLabel.text   // converting the labels display to a string value
        let numberFormatter = NumberFormatter()
            
        let theNumber = numberFormatter.number(from: text!)?.intValue // the number is assigned the value of 100.5
        messageItem?.like()
        likesLabel.text = String(theNumber! + 1)
        
        isLiked.append(messageItem.id)
        disableButton(button:"Like")
    }
    
    @IBAction func dislikeButton(_ sender: UIButton) {
        //Make request to dislike post
        let text = dislikesLabel.text   // converting the labels display to a string value
        let numberFormatter = NumberFormatter()
            
        let theNumber = numberFormatter.number(from: text!)?.intValue // the number is assigned the value of 100.5
        messageItem?.dislike()
        dislikesLabel.text = String(theNumber! + 1)
        
        isDisliked.append(messageItem.id)
        disableButton(button:"Dislike")
        
    }
    
    func disableButton(button: String){
        if button == "Like"{
            likeButton.isEnabled = false
        }
        if button == "Dislike"{
            dislikeButton.isEnabled = false
        }
    }
    
    func enableButton(button: String){
        if button == "Like"{
            likeButton.isEnabled = true
        }
        if button == "Dislike"{
            dislikeButton.isEnabled = true
        }
    }
    
    var cell: Message? {
        didSet {
            guard let cell = cell else {
                return
            }
            self.messageLabel?.text = cell.message
            self.dateLabel?.text = cell.date
            self.likesLabel?.text = String(cell.likes)
            self.dislikesLabel?.text = String(cell.dislikes)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // https://stackoverflow.com/questions/3931838/how-to-write-multiple-lines-in-a-label
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.numberOfLines = 0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
