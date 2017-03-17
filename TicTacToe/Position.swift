//
//  Position.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 16/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

struct Position: Equatable {
    
    let position: Int
    let movementType: Movement.MovementType
    
    static func ==(lhs: Position, rhs: Position) -> Bool {
        return lhs == rhs
    }
    
    func check(playerType: Player.PlayerType) -> Bool {
        
        switch playerType {
        case .playerOne:
            if movementType == .x { return true }
            else { return false }
        case .playerTwo:
            if movementType == .o { return true }
            else { return false }
        }
    }
}
