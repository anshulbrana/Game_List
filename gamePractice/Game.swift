//
//  Game.swift
//  gamePractice
//
//  Created by Anshul Bikram Rana on 11/05/2022.
//

import Foundation

public class Game: Decodable{
    var id: Int = 0
    var name: String
    var smallImageURL: String
    var bigImageURL: String
    var score: Int
    var platform: String
    
    init(id: Int, name: String, smallImageURL: String,bigImageURL: String,score: Int, platform: String){
        self.id = id
        self.name = name
        self.smallImageURL = smallImageURL
        self.bigImageURL = bigImageURL
        self.score = score
        self.platform = platform
    }
    
}

