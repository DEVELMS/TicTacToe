//
//  Sound.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 25/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import UIKit
import AVFoundation

struct Sound {
    
    private var state: State = .on
    
    enum SoundType {
        
        case soundtrack
        case lightsaber
        case blaster
        case win
        case draw
        
        var url: URL {
            
            switch self {
            case .soundtrack: return URL(fileURLWithPath: Bundle.main.path(forResource: "imperial-march", ofType: "wav")!)
            case .lightsaber: return URL(fileURLWithPath: Bundle.main.path(forResource: "lightsaber", ofType: "wav")!)
            case .blaster: return URL(fileURLWithPath: Bundle.main.path(forResource: "blaster", ofType: "wav")!)
            case .win: return URL(fileURLWithPath: Bundle.main.path(forResource: "win", ofType: "wav")!)
            case .draw: return URL(fileURLWithPath: Bundle.main.path(forResource: "win", ofType: "wav")!)
            }
        }
        
        init(movementType: Movement.MovementType) {
            
            switch movementType {
            case .x: self = .lightsaber
            case .o: self = .blaster
            }
        }
        
        init(gameState: Game.GameState.FinishedState) {
            
            switch gameState {
            case .win(_): self = .win
            case .draw: self = .draw
            }
        }
    }
    
    enum State {
        
        case on
        case off
        
        var isOn: Bool {
            switch self {
            case .on: return true
            case .off: return false
            }
        }
        
        var image: UIImage {
            switch self {
            case .on: return #imageLiteral(resourceName: "soundOn")
            case .off: return #imageLiteral(resourceName: "soundOff")
            }
        }
    }
    
    func getState() -> State {
        
        return state
    }
    
    mutating func setState(state: State)  {
        
        self.state = state
        Config.sharedInstance.playerToSoundtrack.isMuted = !state.isOn
        Config.sharedInstance.playerToMovements.isMuted = !state.isOn
    }
    
    mutating func startSoundtrack() {
        
        playSoundtrackSound(url: SoundType.soundtrack.url)
        
        NotificationCenter.default.addObserver(self, selector: Selector({"soundTrackFinished"}()), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: Config.sharedInstance.playerToSoundtrack.currentItem)
    }
    
    mutating func playMovementSound(movementType: Movement.MovementType) {
        
        playMovementSound(url: SoundType(movementType: movementType).url)
    }
    
    mutating func playGameStateSound(gameState: Game.GameState.FinishedState) {
        
        playMovementSound(url: SoundType(gameState: gameState).url)
    }
    
    private func playMovementSound(url: URL) {
        
        Config.sharedInstance.playerToMovements = AVPlayer(url: url)
        Config.sharedInstance.playerToMovements.play()
    }
    
    private func playSoundtrackSound(url: URL) {
        
        Config.sharedInstance.playerToSoundtrack = AVPlayer(url: url)
        Config.sharedInstance.playerToSoundtrack.play()
    }
    
    func soundTrackFinished(notification: NSNotification) {
        print("soundTrackFinished")
        Config.sharedInstance.playerToSoundtrack.seek(to: kCMTimeZero)
        Config.sharedInstance.playerToSoundtrack.play()
    }
}
