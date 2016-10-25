//
//  Player.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 16/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

struct Player {

    let name: String
    let playerType: PlayerType
    let human: Bool
    var wins = Int()
    
    enum PlayerType {
        case playerOne
        case playerTwo
    }
    
    init(name: String, playerType: PlayerType, human: Bool) {
        
        self.name = name
        self.playerType = playerType
        self.human = human
    }
    
    mutating func addWin() {
    
        self.wins += 1
    }
    
}
