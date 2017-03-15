//
//  Moving.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 14/03/17.
//  Copyright © 2017 Lucas M Soares. All rights reserved.
//

protocol Moving {
    
    func doMovement(at: Field) -> Movement?
}
