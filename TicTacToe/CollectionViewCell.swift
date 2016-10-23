//
//  CollectionViewCell.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 16/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var item: UIImageView!
    
    func setItem(type: Movement.MovementType? = nil) {
        
        guard let type = type else {
            
            item.image = nil
            return
        }
        
        switch type {
            
        case .o: item.image = #imageLiteral(resourceName: "deathstar")
        case .x: item.image = #imageLiteral(resourceName: "saber")
        }
    }
    
}
