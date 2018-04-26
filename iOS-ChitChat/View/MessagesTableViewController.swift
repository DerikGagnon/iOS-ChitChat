//
//  ViewController.swift
//  iOS-ChitChat
//
//  Created by Gagnon, Derik on 4/19/18.
//  Copyright © 2018 Gagnon, Derik. All rights reserved.
//

import UIKit
import Alamofire

class MessagesTableViewController: UITableViewController {
    var messages: [Message] = []
    var message: Message!
    var numMessages: Int = 20

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
        cell.setMessage(message: messages[indexPath.row])
        
//        cell.likesLabel.text = String(m.likes)
//        cell.dislikesLabel.text = String(m.dislikes)
//        cell.dateLabel.text = m.date
//        cell.messageLabel.text = m.message
        
        return cell
    }
    
    func getData() {
        Alamofire.request("https://www.stepoutnyc.com/chitchat", method: .get, parameters: ["key" : API_KEY, "client" : CLIENT]).responseJSON { response in
            if let json = response.result.value {
                let jsonDict = json as! NSDictionary
                let jsonMessages = jsonDict["messages"] as! NSArray
                self.messages.removeAll()
                
                for jsonMessage in jsonMessages {
                    let messageText = jsonMessage as! NSDictionary as! [String: Any]
                    self.message = Message(json: messageText)
                    self.messages.append(self.message)
                    print (self.message.id)
                }
            }
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        //tableView.rowHeight = 100
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
}

