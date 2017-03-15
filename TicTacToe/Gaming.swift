//
//  Gaming.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 23/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import UIKit

protocol Gaming {
    
    func finishedGame(state: Game.GameState.FinishedState)
    func activePlayer(activePlayer: Player)
    func cpuPlayed(movement: Movement)
    func turnOff()
    func showConfigModal(sender: UIButton)
}
