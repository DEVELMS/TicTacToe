//
//  Sound.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 25/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import UIKit

enum SoundType {
    
    case lightsaber
    case blaster
    case soundtrack
}

enum State {

    case on
    case off
    
    var image: UIImage {
        switch self {
        case .on: return #imageLiteral(resourceName: "soundOn")
        case .off: return #imageLiteral(resourceName: "soundOff")
        }
    }
}

struct Sound {
    
    var state: State
    
    init(state: State) {
        
        self.state = state
    }
    
    func getSoundType(soundType: SoundType) {
    
    
    }
}
