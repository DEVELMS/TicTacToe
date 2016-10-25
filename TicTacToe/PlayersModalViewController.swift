//
//  PlayersModalViewController.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 22/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import UIKit

class PlayersModalViewController: UIViewController {
    
    @IBOutlet private weak var playerNick2: UITextField!
    @IBOutlet private weak var playerNick1: UITextField!
    
    var delegate: Choosing?
    
    func configModal(_ sender: UIButton) {
    
        guard let delegate = delegate else {
            print("delegate not setted")
            return
        }
        
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.backgroundColor = UIColor(hexadecimal: 0xF0F0F0)
        self.popoverPresentationController?.sourceRect = CGRect(x: sender.bounds.width / 2, y: 0, width: 0, height: 0)
        self.preferredContentSize = CGSize(width: 300, height: 200)
        self.popoverPresentationController?.delegate = delegate as? UIPopoverPresentationControllerDelegate
        self.popoverPresentationController?.sourceView = sender
    }
    
    @IBAction func jogar(_ sender: AnyObject) {
        
        guard let delegate = delegate else {
            print("delegate not setted")
            return
        }
        
        guard playerNick1.text != "", playerNick2.text != "" else {
            print("you must type the usernames to continue")
            return
        }
        
        let players = [ Player(name: playerNick1.text!, playerType: Player.PlayerType.playerOne, human: true), Player(name: playerNick2.text!, playerType: Player.PlayerType.playerTwo, human: true) ]
        
        delegate.pvpSelected(gameType: GameType.pvp(players: players))
    }
    
}
