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
        self.popoverPresentationController?.permittedArrowDirections = .right
        self.popoverPresentationController?.backgroundColor = UIColor(hexadecimal: 0xF0F0F0)
        self.popoverPresentationController?.sourceRect = CGRect(x: sender.bounds.origin.x, y: sender.bounds.height, width: 0, height: 0)
        self.preferredContentSize = CGSize(width: 80, height: 80)
        self.popoverPresentationController?.delegate = delegate as? UIPopoverPresentationControllerDelegate
        self.popoverPresentationController?.sourceView = sender
    }
    
    @IBAction func changeSoundState(_ sender: AnyObject) {
        
        print("cange sound state")
    }

}
