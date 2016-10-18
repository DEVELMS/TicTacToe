//
//  Move.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 16/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

struct Movement {
    
    let player: Player
    let movementType: MovementType
    let position: Position
    
    enum MovementType {
        case x
        case o
        
        init(player: Player) {
            
            switch player.playerType {
            case .playerOne:
                self = .x
            case .playerTwo:
                self = .o
            }
        }
    }
    
    init(player: Player, position: Int) {
        
        self.player = player
        self.movementType = MovementType(player: player)
        self.position = Position(position: position, movementType: self.movementType)
    }
}
