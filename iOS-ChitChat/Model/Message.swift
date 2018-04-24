//
//  Message.swift
//  iOS-ChitChat
//
//  Created by Gagnon, Derik on 4/24/18.
//  Copyright © 2018 Gagnon, Derik. All rights reserved.
//

import Foundation

struct Message: Codable {
    let id:String
    let client: String
    let date: Date
    let dislikes: Int
    let ip: String
    let likes: Int
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
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz" //Your date format
        let date = dateFormatter.date(from: dateJSON) //according to date format your date string
        
        let coordinatesJSON = json["loc"] as? [String]
        
        self.id = idJSON
        self.client = clientJSON.components(separatedBy: "@")[0]
        self.dislikes = dislikesJSON
        self.ip = ipJSON
        self.likes = likesJSON
        self.loc = coordinatesJSON
    }
}
