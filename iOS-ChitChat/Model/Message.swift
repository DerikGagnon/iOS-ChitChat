//
//  Message.swift
//  iOS-ChitChat
//
//  Created by Gagnon, Derik on 4/24/18.
//  Copyright © 2018 Gagnon, Derik. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

let API_KEY = "524d4955-63f6-40bb-b5e0-63caea8b981d"
let CLIENT = "derik.gagnon@mymail.champlain.edu"

struct Message {
    let id:String
    let date: String
    var dislikes: Int
    let ip: String
    var likes: Int
    var loc: CLLocationCoordinate2D?
    let message: String
    let defaults = UserDefaults.standard
    
    init?(json: [String: Any]) {
        let idJSON = json["_id"] as? String
        let dateJSON = json["date"] as? String
        let dislikesJSON = json["dislikes"] as? Int
        let ipJSON = json["ip"] as? String
        let likesJSON = json["likes"] as? Int
        let messageJSON = json["message"] as? String
    
        //let coordinatesJSON = json["loc"] as? [String]
        if let coordinatesJSON = json["loc"] as? [Any] {
            if Double(String(describing: coordinatesJSON[0])) != nil && Double(String(describing: coordinatesJSON[1])) != nil {
                let longitude: Double = Double(String(describing: coordinatesJSON[0]))!
                let latitude: Double = Double(String(describing: coordinatesJSON[1]))!
                self.loc = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
            }
        }
        
        self.id = idJSON!
        self.dislikes = dislikesJSON!
        self.ip = ipJSON!
        self.likes = likesJSON!
        
        //self.loc = coordinatesJSON!
        self.message = messageJSON!
        self.date = dateJSON!
    }
    
    mutating func like() {
        //Stores the Liked messages in an array for freezing later
        print("Inside like function")
        var likes = (UserDefaults.standard.array(forKey: "likes") ?? []) as! [String]
        //let dislikes = (UserDefaults.standard.array(forKey: "dislikes") ?? []) as! [String]
        //if !likes.contains(id) && !dislikes.contains(id) {
            likes.append(id)
            print(id)
            self.likes += 1
            let url: String = "https://www.stepoutnyc.com/chitchat/like/" + id
            Alamofire.request(url, method: .get , parameters: ["key" : API_KEY, "client" : CLIENT])
            UserDefaults.standard.set(likes, forKey: "likes")
        //}
    }
    
    mutating func dislike() {
        //Stores the Disliked messages in an array for freezing later
        print("Inside dislike function")
        //let likes = (UserDefaults.standard.array(forKey: "likes") ?? []) as! [String]
        var dislikes = (UserDefaults.standard.array(forKey: "dislikes") ?? []) as! [String]
        //if !likes.contains(id) && !dislikes.contains(id) {
            dislikes.append(id)
            print(id)
            self.dislikes += 1
            let url: String = "https://www.stepoutnyc.com/chitchat/dislike/" + id
            Alamofire.request(url, method: .get , parameters: ["key" : API_KEY, "client" : CLIENT])
            UserDefaults.standard.set(dislikes, forKey: "dislikes")
        //}
    }
}
