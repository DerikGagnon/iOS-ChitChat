//
//  ViewController.swift
//  iOS-ChitChat
//
//  Created by Gagnon, Derik on 4/19/18.
//  Copyright © 2018 Gagnon, Derik. All rights reserved.
//

import UIKit

class MessagesTableViewController: UITableViewController {
    var messages: [Message] = []
    var message: Message!
    var numMessages: Int = 20

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
        let m = messages[indexPath.row]
        
        cell.likes.text = String(m.likes)
        cell.dislikes.text = String(m.dislikes)
        cell.date.text = m.date
        cell.message.text = m.message
        
        return cell
    }


}

