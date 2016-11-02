//
//  Delay.swift
//  TicTacToe
//
//  Created by Storm on 01/11/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import Foundation

struct Delay {
    
    static func wait(seconds: Double, completion: @escaping () -> Void) {
        
        let time = DispatchTime.now() + seconds
        
        DispatchQueue.main.asyncAfter(deadline: time) {
            
            completion()
        }
    }
}
