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
    
//    var cell: Message? {
//        didSet {
//            guard let cell = cell else {
//                return
//            }
//            self.message?.text = cell.message
//            self.date?.text = cell.date
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
