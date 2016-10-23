//
//  ChoiceViewController.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 22/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import UIKit

class ChoiceViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    lazy var playersModal: PlayersModalViewController = PlayersModalViewController(nibName: PlayersModalViewController.identifier, bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func chooseCPU(_ sender: UIButton) {
        
        performSegue(withIdentifier: "sgGame", sender: self)
    }
    
    @IBAction func showPlayersModal(_ sender: UIButton) {
        
        configPlayersModal(sender);
        self.present(playersModal, animated: true, completion: nil)
    }
    
    private func configPlayersModal(_ sender: UIButton) {
        
        playersModal.modalPresentationStyle = .popover
        playersModal.popoverPresentationController?.sourceRect = CGRect(x: sender.bounds.width / 2, y: 0, width: 0, height: 0)
        playersModal.preferredContentSize = CGSize(width: 300, height: 180)
        playersModal.popoverPresentationController?.delegate = self
        playersModal.popoverPresentationController?.sourceView = sender
    }
    
    //Mark: UIPopoverPresentationDelegate
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .none
    }
}
