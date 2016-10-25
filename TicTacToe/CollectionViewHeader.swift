//
//  CollectionViewHeader.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 22/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import UIKit

class CollectionViewHeader: UICollectionReusableView {
        
    @IBOutlet private weak var activePlayer: UILabel!
    
    var delegate: Gaming?
    
    func setTitle(name: String) {
        
        var text = "É a vez de \(name)."
        
        if name == "Você" { text = "É a sua vez." }
        
        self.activePlayer.text = text
    }
    
    @IBAction func turnOff(_ sender: AnyObject) {
        
        guard let delegate = delegate else {
            print("delegate not setted")
            return
        }
        delegate.turnOff()
    }
}
