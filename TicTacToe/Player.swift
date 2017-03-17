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
    
        if !self.human {
            
            if Config.sharedInstance.difficulty.getDifficulty() == .hard {
                return accurateMovement(field: at)
            }
            
            return softMovement(field: at)
        }
        else {
            print("just machines can do that")
            return nil
        }
    }
    
    func softMovement(field: Field) -> Movement? {
        
        var randomPositions = Field.positionstoWin
        
        randomPositions = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: randomPositions) as! [[Int]]
        
        // I will try do a move
        for positions in Field.positionstoWin {
            
            var isOk = true
            var position_ = 99
            
            for position in positions {
                
                let wasPlayedByMe = field.check(position: position, wasPlayedBy: self)
                let isEmpty = field.check(position: position)
                
                if !isEmpty && !wasPlayedByMe {
                    isOk = false
                    break
                }
                else if isEmpty { position_ = position }
            }
            
            if isOk, position_ != 99 { return Movement(player: self, position: position_) }
        }
        
        return randomMovement(field: field)
    }
    
    func accurateMovement(field: Field) -> Movement? {
        
        // Can i win?
        for positions in Field.positionstoWin {
            
            var iWillWin = Bool()
            var position_ = 99
            var alerts = 0
            
            for position in positions {
                
                let wasPlayedByMe = field.check(position: position, wasPlayedBy: self)
                let isEmpty = field.check(position: position)
                
                if isEmpty { position_ = position }
                else if wasPlayedByMe { alerts += 1 }
                if alerts >= 2 { iWillWin = true }
            }
            
            if iWillWin, position_ != 99 { return Movement(player: self, position: position_) }
        }
        // Can Human win?
        for positions in Field.positionstoWin {
            
            var humanWillWin = Bool()
            var position_ = 99
            var alerts = 0
            
            for position in positions {
                
                let wasPlayedByMe = field.check(position: position, wasPlayedBy: self)
                let isEmpty = field.check(position: position)
                
                if isEmpty { position_ = position }
                else if !wasPlayedByMe { alerts += 1 }
                if alerts >= 2 { humanWillWin = true }
            }
            
            if humanWillWin, position_ != 99 { return Movement(player: self, position: position_) }
        }
        
        return softMovement(field: field)
    }
    
    func randomMovement(field: Field) -> Movement? {
        
        var movement: Movement?
        
        var randomPositions = [Int]()
        
        for index in (0 ..< Field.maxPositions)  {
            randomPositions.append(index)
        }
        
        randomPositions = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: randomPositions) as! [Int]
        
        for position in randomPositions {
            
            if field.check(position: position) {
                movement = Movement(player: self, position: position)
            }
        }
        
        return movement
    }
}
