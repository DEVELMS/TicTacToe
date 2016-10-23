//
//  Gaming.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 23/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

protocol Gaming: AnyObject {
    
    var game: Game { get set }
    
    func finishedGame(state: GameState.FinishedState)
    func activePlayer(activePlayer: Player)
    func turnOff()
}
