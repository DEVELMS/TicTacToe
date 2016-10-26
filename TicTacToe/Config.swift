//
//  Config.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 25/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import AVFoundation

final class Config {
    
    // Can't init is singleton
    private init() { }
    
    //MARK: Shared Instance
    
    static let sharedInstance: Config = Config()
    
    //MARK: Local Variable
    var playerToMovements = AVPlayer()
    var playerToSoundtrack = AVPlayer()
    var sound = Sound()
}
