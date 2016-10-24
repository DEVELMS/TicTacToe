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
        
        var text = ", \(name)"
        
        if name == "Você" { text = "" }
        
        self.activePlayer.text = "É a sua vez\(text)"
    }
    
    @IBAction func turnOff(_ sender: AnyObject) {
        
        guard let delegate = delegate else {
            print("delegate not setted")
            return
        }
        delegate.turnOff()
    }
}
