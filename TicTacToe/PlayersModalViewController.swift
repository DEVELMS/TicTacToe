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
    
    @IBAction func cancelar(_ sender: AnyObject) {
        
        print("cancelar")
    }
    
    @IBAction func jogar(_ sender: AnyObject) {
        
        print("jogar")
    }
    
}
