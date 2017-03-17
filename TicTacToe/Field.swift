//
//  Field.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 17/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

struct Field {
    
    private var positions = [Position]()
    static let maxPositions = 9
    static let positionstoWin = [[0,1,2],
                                 [3,4,5],
                                 [6,7,8],
                                 [0,3,6],
                                 [1,4,7],
                                 [2,5,8],
                                 [0,4,8],
                                 [2,4,6]]
    
    mutating func cleanPositions() {
        
        self.positions = [Position]()
    }
    
    func getPositions() -> [Position] {
    
        return positions
    }
    
    mutating func checkFieldPositions(movement: Movement) -> Bool {
        
        guard checkPositionEmpty(position: movement.position.position) else {
            print("position not empty")
            return false
        }
        
        markFieldPosition(movement: movement)
        
        return true
    }
    
    func check(position: Int) -> Bool {
        
        guard checkPositionEmpty(position: position) else {
            return false
        }
        
        return true
    }
    
    func check(position: Int, wasPlayedBy: Player) -> Bool {
        
        return !positions.filter {
            $0.position == position &&
            $0.check(playerType: wasPlayedBy.playerType)
        }.isEmpty
    }
    
    private func checkPositionEmpty(position: Int) -> Bool {
        
        return positions.filter { $0.position == position }.isEmpty
    }
    
    func checkPositions(position: Position) -> Bool {
        
        return !positions.filter {
                $0.position == position.position &&
                $0.movementType == position.movementType
            }.isEmpty
    }
    
    private mutating func markFieldPosition(movement: Movement) {
        
        self.positions.append(Position(position: movement.position.position, movementType: movement.movementType))
    }
    
}

