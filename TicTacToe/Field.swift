//
//  Field.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 17/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

struct Field {
    
    private var positions = [Position]()
    let maxPositions = 9
    
    mutating func cleanPositions() {
        
        self.positions = [Position]()
    }
    
    func getPositions() -> [Position] {
    
        return positions
    }
    
    mutating func checkFieldPositions(movement: Movement) -> Bool {
        
        guard checkPositionEmpty(position: movement.position) else {
            print("position not empty")
            return false
        }
        
        markFieldPosition(movement: movement)
        
        return true
    }
    
    mutating func checkFieldPositionsToCpu(movement: Movement) -> Bool {
        
        guard checkPositionEmpty(position: movement.position) else {
            return false
        }
        
        return true
    }
    
    private func checkPositionEmpty(position: Position) -> Bool {
        
        return positions.filter { $0.position == position.position }.isEmpty
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

