//
//  CollectionViewFooter.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 23/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import UIKit

class CollectionViewFooter: UICollectionReusableView {
    
    @IBOutlet private weak var player1Status: UILabel!
    @IBOutlet private weak var player2Status: UILabel!
    @IBOutlet private weak var drawnStatus: UILabel!
    
    func updateVictories(player: Player) {
        
        var texto = "vitórias"
        
        if (player.wins == 1) {
            texto = "vitória"
        }
        
        switch player.playerType {
        case .playerOne:
            player1Status.text = ("\(player.name): \(player.wins) \(texto)")
        case .playerTwo:
            player2Status.text = ("\(player.name): \(player.wins) \(texto)")
        }
    }
    
    func updateDrawns() {
        
        let drawns: String = drawnStatus.text!
        drawnStatus.text = ("\(Int(drawns)! + 1)")
    }
}
