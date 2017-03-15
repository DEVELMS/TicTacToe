//
//  Player.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 16/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import GameplayKit

struct Player: Moving {

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
    
    // MARK: Private funcs
    
    mutating func winned() {
        self.wins += 1
    }
    
    // MARK: Moving Protocol
    
    func doMovement(at: Field) -> Movement? {
    
        if !self.human { return randomMovement(field: at) }
        else {
            print("just machines can do that")
            return nil
        }
    }
    
    func randomMovement(field: Field) -> Movement? {
        
        var randomPositions = [Int]()
        
        for index in (0 ..< Field.maxPositions)  {
            randomPositions.append(index)
        }
        
        randomPositions = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: randomPositions) as! [Int]
        
        for position in randomPositions {
            
            if field.check(position: position) {
                return Movement(player: self, position: position)
            }
        }
        
        return nil
    }
    
//    mutating func accurateMovement(field: inout Field) -> Movement {
//        
//        var randomPositions = [Int]()
//        
//        for index in (0..<field.maxPositions)  {
//            randomPositions.append(index)
//        }
//        
//        randomPositions = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: randomPositions) as! [Int]
//        
//        for position in randomPositions {
//            
//            let movement = Movement(player: self.player, position: position)
//            
//            if field.checkFieldPositionsToCpu(movement: movement) {
//                return movement
//            }
//        }
//        
//        assert(false, "randomMovement(without available position)")
//    }
}
