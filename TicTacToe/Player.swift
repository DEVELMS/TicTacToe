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
    var movements = [Movement]()
    var wins = Int()
    
    enum PlayerType {
        case playerOne
        case playerTwo
    }
    
    init(name: String, playerType: PlayerType) {
        
        self.name = name
        self.playerType = playerType
    }
    
    mutating func setMovements(position: Int) {
        
        self.movements.append(Movement(player: self, position: position))
    }
    
    mutating func addWin() {
    
        self.wins += 1
    }
    
}
