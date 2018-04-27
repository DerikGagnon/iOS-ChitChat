//
//  ViewController.swift
//  iOS-ChitChat
//
//  Created by Gagnon, Derik on 4/19/18.
//  Copyright © 2018 Gagnon, Derik. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class MessagesTableViewController: UITableViewController {
    
    @IBAction func sendMessageButton(_ sender: UIBarButtonItem) {
        
        //Taken from https://stackoverflow.com/questions/26567413/get-input-value-from-textfield-in-ios-alert-in-swift
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Chit Chat", message: "Send Message", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = "Enter text here.."
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.sendMessage(message: (textField?.text)!)
            self.getData()
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    
    var messages: [Message] = []
    var message: Message!
    var numMessages: Int = 20
    let defaults = UserDefaults.standard
    var isLiked:Array<String> = []
    var isDisliked:Array<String> = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    //Pull to refresh
    @IBAction func refresh(_ sender: UIRefreshControl) {
        getData()
        sender.endRefreshing()
    }
    
    //Enabling and disabling the like/dislike button from the liked and disliked posts
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell

        cell.setMessage(message: messages[indexPath.row])
        if isLiked.contains(messages[indexPath.row].id){
            cell.disableButton(button: "Like")
        }
        else{
            cell.enableButton(button: "Like")
        }
        
        if isDisliked.contains(messages[indexPath.row].id){
            cell.disableButton(button: "Dislike")
        }
        else{
            cell.enableButton(button: "Dislike")
        }
        
        return cell
    }
    
    //Get the first 20 messages
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
                }
            }
            self.tableView.reloadData()
        }
    }
    
    //Simple function that creates the swiping action to like a message.
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let cell = tableView.cellForRow(at: indexPath) as! MessageCell
        let likeAction = UIContextualAction(style: .normal, title: "Like", handler: { (ac:UIContextualAction, view: UIView, success: (Bool) -> Void) in success(true)
            self.messages[indexPath.row].like()
            
            let text = cell.likesLabel.text   // converting the labels display to a string value
            let numberFormatter = NumberFormatter()
            let theNumber = numberFormatter.number(from: text!)?.intValue
            cell.likesLabel.text = String(theNumber! + 1)
            
            cell.likeButton.isEnabled = false
        })
        likeAction.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [likeAction])
    }
    
    //Same as for the other swiping action but dislikes instead
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let cell = tableView.cellForRow(at: indexPath) as! MessageCell
        let dislikeAction = UIContextualAction(style: .normal, title: "Dislike", handler: { (ac:UIContextualAction, view: UIView, success: (Bool) -> Void) in success(true)
            self.messages[indexPath.row].dislike()
            
            let text = cell.dislikesLabel.text   // converting the labels display to a string value
            let numberFormatter = NumberFormatter()
            let theNumber = numberFormatter.number(from: text!)?.intValue
            cell.dislikesLabel.text = String(theNumber! + 1)
            
            cell.dislikeButton.isEnabled = false
        })
        dislikeAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [dislikeAction])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loads the defaults for likes/dislikes
        isLiked = defaults.stringArray(forKey: "likes") ?? [String] ()
        isDisliked = defaults.stringArray(forKey: "dislikes") ?? [String] ()
        getData()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                if let vc = segue.destination as? MessagesViewController{
                    
                    //Default location 
                    if messages[indexPath.row].loc == nil{
                        vc.lat = 0.0
                        vc.lon = 0.0
                    }
                    else{
                        vc.lat = (messages[indexPath.row].loc?.latitude)!
                        vc.lon = (messages[indexPath.row].loc?.longitude)!
                    }

                    //Check for the urls with pmg and jpg extension
                    let messageArray:Array<String> = messages[indexPath.row].message.components(separatedBy: " ")
                    for index in 0...messageArray.count - 1{
                        if (messageArray[index] == ""){
                            continue
                        }
                        let url = URL(string: messageArray[index])
                        if url?.pathExtension == "png" || url?.pathExtension == "jpg" {
                            vc.url = url!
                        }
                    }
                }
            }

        }
    }
    
    func sendMessage (message: String) {
        
        //Default values
        var lat: String = "0.0"
        var lon: String = "0.0"
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        var currentLocation: CLLocation!
        currentLocation = locationManager.location
        
        //Default setup
        locationManager.desiredAccuracy = 1.0
        locationManager.distanceFilter = 1.0
        locationManager.startUpdatingLocation()
        if locationManager.location != nil {
            lon = "\(currentLocation.coordinate.longitude)"
            lat = "\(currentLocation.coordinate.latitude)"
        }
        locationManager.stopUpdatingLocation()
        
        //Send Message here
        let url: String = "https://www.stepoutnyc.com/chitchat"
        Alamofire.request(url, method: .post , parameters: ["key" : API_KEY, "client" : CLIENT, "message" : message, "lat" : lat, "lon" : lon])
        
    }
}

