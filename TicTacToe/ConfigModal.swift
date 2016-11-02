//
//  ConfigModal.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 25/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import UIKit

class ConfigModal: UIViewController {

    var delegate: Configuring?
    
    func configModal(_ sender: UIButton) {
        
        guard let delegate = delegate else {
            print("delegate not setted")
            return
        }
        
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.permittedArrowDirections = .up
        self.popoverPresentationController?.backgroundColor = UIColor(hexadecimal: 0xF0F0F0)
        self.popoverPresentationController?.sourceRect = CGRect(x: sender.bounds.width, y: sender.bounds.height, width: 0, height: 0)
        self.preferredContentSize = CGSize(width: 75, height: 90)
        self.popoverPresentationController?.delegate = delegate
        self.popoverPresentationController?.sourceView = sender
    }
    
    @IBAction func changeSoundState(_ sender: UIButton) {
        
        switch Config.sharedInstance.sound.getState() {
        case .on: Config.sharedInstance.sound.setState(state: .off)
        case .off: Config.sharedInstance.sound.setState(state: .on)
        }
        
        sender.setImage(Config.sharedInstance.sound.getState().image, for: .normal)
    }

    @IBAction func changeDifficulty(_ sender: UIButton) {
        
        switch Config.sharedInstance.difficulty.getDifficulty() {
        case .hard: Config.sharedInstance.difficulty.setDifficulty(difficulty: .easy)
        case .easy: Config.sharedInstance.difficulty.setDifficulty(difficulty: .hard)
        }
        
        sender.tintColor = Config.sharedInstance.difficulty.getDifficulty().color
        sender.setTitle(Config.sharedInstance.difficulty.getDifficulty().description, for: .normal)
    }
    
}
