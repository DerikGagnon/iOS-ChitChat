//
//  Message.swift
//  iOS-ChitChat
//
//  Created by Gagnon, Derik on 4/24/18.
//  Copyright © 2018 Gagnon, Derik. All rights reserved.
//

import Foundation
import Alamofire

let API_KEY = "524d4955-63f6-40bb-b5e0-63caea8b981d";
let CLIENT = "derik.gagnon@mymail.champlain.edu";

struct Message: Codable {
    let id:String
    let client: String
    let date: String
    var dislikes: Int
    let ip: String
    var likes: Int
    let loc: [String?]
    let message: String
    
    init?(json: [String: Any]) {
        guard let idJSON = json["_id"] as? String,
            let clientJSON = json["client"] as? String,
            let dateJSON = json["date"] as? String,
            let dislikesJSON = json["dislikes"] as? Int,
            let ipJSON = json["ip"] as? String,
            let likesJSON = json["likes"] as? Int,
            
            let messageJSON = json["message"] as? String
            else {
                return nil
        }
    
        let coordinatesJSON = json["loc"] as? [String]
        
        self.id = idJSON
        self.client = clientJSON.components(separatedBy: "@")[0]
        self.dislikes = dislikesJSON
        self.ip = ipJSON
        self.likes = likesJSON
        self.loc = coordinatesJSON!
        self.message = messageJSON
        self.date = dateJSON
    }
    
    mutating func like() {
        //Stores the Liked messages in an array for freezing later
        var likes = (UserDefaults.standard.array(forKey: "likes") ?? []) as! [String]
        let dislikes = (UserDefaults.standard.array(forKey: "dislikes") ?? []) as! [String]
        if !likes.contains(id) && !dislikes.contains(id) {
            likes.append(id)
            self.likes += 1
            let url: String = "https://www.stepoutnyc.com/chitchat/like/" + id
            Alamofire.request(url, method: .get , parameters: ["key" : API_KEY, "client" : CLIENT])
            UserDefaults.standard.set(likes, forKey: "likes")
        }
    }
    
    mutating func dislike() {
        //Stores the Disliked messages in an array for freezing later
        let likes = (UserDefaults.standard.array(forKey: "likes") ?? []) as! [String]
        var dislikes = (UserDefaults.standard.array(forKey: "dislikes") ?? []) as! [String]
        if !likes.contains(id) && !dislikes.contains(id) {
            dislikes.append(id)
            self.dislikes += 1
            let url: String = "https://www.stepoutnyc.com/chitchat/dislike/" + id
            Alamofire.request(url, method: .get , parameters: ["key" : API_KEY, "client" : CLIENT])
            UserDefaults.standard.set(dislikes, forKey: "dislikes")
        }
    }
}
