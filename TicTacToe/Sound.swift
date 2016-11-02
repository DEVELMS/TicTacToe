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
    private var playerToMovements = AVPlayer()
    private var playerToSoundtrack = AVPlayer()
    
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
        playerToSoundtrack.isMuted = !state.isOn
        playerToMovements.isMuted = !state.isOn
    }
    
    mutating func startSoundtrack() {
        
        playSoundtrackSound(url: SoundType.soundtrack.url)
        
        NotificationCenter.default.addObserver(self, selector: Selector({"soundTrackFinished"}()), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerToSoundtrack.currentItem)
    }
    
    mutating func playMovementSound(movementType: Movement.MovementType) {
        
        playMovementSound(url: SoundType(movementType: movementType).url)
    }
    
    mutating func playGameStateSound(gameState: Game.GameState.FinishedState) {
        
        playMovementSound(url: SoundType(gameState: gameState).url)
    }
    
    private mutating func playMovementSound(url: URL) {
        
        playerToMovements = AVPlayer(url: url)
        playerToMovements.play()
    }
    
    private mutating func playSoundtrackSound(url: URL) {
        
        playerToSoundtrack = AVPlayer(url: url)
        playerToSoundtrack.play()
    }
    
    func soundTrackFinished(notification: NSNotification) {
        print("soundTrackFinished")
        playerToSoundtrack.seek(to: kCMTimeZero)
        playerToSoundtrack.play()
    }
}
