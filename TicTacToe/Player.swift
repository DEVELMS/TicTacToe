//
//  Player.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 16/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import GameplayKit

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
    
    mutating func randomMovement(field: inout Field) -> Movement {
        
        var randomPositions = [Int]()
        
        for index in (0..<field.maxPositions)  {
            randomPositions.append(index)
        }
        
        randomPositions = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: randomPositions) as! [Int]
        
        for position in randomPositions {
            
            let movement = Movement(player: self, position: position)
            
            if field.checkFieldPositionsToCpu(movement: movement) {
                return movement
            }
        }
        
        assert(false, "randomMovement(nenhuma posição disponível)")
    }
    
    mutating func accurateMovement(field: inout Field) -> Movement {
        
        var randomPositions = [Int]()
        
        for index in (0..<field.maxPositions)  {
            randomPositions.append(index)
        }
        
        randomPositions = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: randomPositions) as! [Int]
        
        for position in randomPositions {
            
            let movement = Movement(player: self, position: position)
            
            if field.checkFieldPositionsToCpu(movement: movement) {
                return movement
            }
        }
        
        assert(false, "randomMovement(nenhuma posição disponível)")
    }
}
