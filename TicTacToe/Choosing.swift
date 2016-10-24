//
//  Choosing.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 23/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

protocol Choosing: AnyObject {
    
    var game: Game { get set }
    
    func pvpSelected(gameType: GameType)
}
