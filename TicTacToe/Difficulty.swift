//
//  Difficulty.swift
//  TicTacToe
//
//  Created by Storm on 01/11/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import UIKit

struct Difficulty {
    
    private var type: Type
    
    enum `Type` {
        
        case hard
        case easy
        
        var color: UIColor {
        
            switch self {
            case .hard: return UIColor(hexadecimal: 0x960E00)
            case .easy: return UIColor(hexadecimal: 0x3FBD38)
            }
        }
        
        var description: String {
        
            switch self {
            case .hard: return "Difícil"
            case .easy: return "Fácil"
            }
        }
    }

    init(type: Type) {
        self.type = type
    }
    
    func getDifficulty() -> Type {
    
        return self.type
    }
    
    mutating func setDifficulty(difficulty: Type) {
    
        self.type = difficulty
    }

}
