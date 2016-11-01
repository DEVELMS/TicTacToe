//
//  Difficulty.swift
//  TicTacToe
//
//  Created by Storm on 01/11/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import UIKit

struct Difficulty {
    
    var type = Type.hard
    
    enum `Type` {
        
        case hard
        case easy
        
        var color: UIColor {
        
            switch self {
            case .hard: return UIColor(hexadecimal: 0xFFFFFF)
            case .easy: return UIColor(hexadecimal: 0xFFFFFF)
            }
        }
    }
    
    mutating func setDifficulty(difficulty: Type) {
    
        self.type = difficulty
    }
}
