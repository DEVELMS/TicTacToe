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
    static let positionstoWin = [[0,1,2],
                                 [3,4,5],
                                 [6,7,8],
                                 [0,3,6],
                                 [1,4,7],
                                 [2,5,8],
                                 [0,4,8],
                                 [2,4,6]]
    
    static func ==(lhs: Position, rhs: Position) -> Bool {
        return lhs == rhs
    }
}
