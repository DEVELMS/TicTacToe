//
//  ChoiceViewController.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 22/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import UIKit

class ChoiceViewController: UIViewController, UIPopoverPresentationControllerDelegate, Choosing {

    var game = Game()
    lazy var playersModal: PlayersModalViewController = PlayersModalViewController(nibName: PlayersModalViewController.identifier, bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playersModal.delegate = self
    }

    @IBAction func chooseCPU(_ sender: UIButton) {
        
        game.setGameType(gameType: GameType.cpu)
        performSegue(withIdentifier: "sgGame", sender: self)
    }
    
    @IBAction func showPlayersModal(_ sender: UIButton) {
        
        configPlayersModal(sender);
        self.present(playersModal, animated: true, completion: nil)
    }
    
    private func configPlayersModal(_ sender: UIButton) {
        
        playersModal.modalPresentationStyle = .popover
        playersModal.popoverPresentationController?.sourceRect = CGRect(x: sender.bounds.width / 2, y: 0, width: 0, height: 0)
        playersModal.preferredContentSize = CGSize(width: 300, height: 190)
        playersModal.popoverPresentationController?.delegate = self
        playersModal.popoverPresentationController?.sourceView = sender
    }
    
    //Mark: Choosing
    
    func pvpSelected(gameType: GameType) {
        game.setGameType(gameType: gameType)
        performSegue(withIdentifier: "sgGame", sender: self)
    }
    
    //Mark: UIPopoverPresentationDelegate
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .none
    }
    
    //Mark: UINavigationControllerDelegate
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "sgGame" {
            let collectionViewController = segue.destination as! CollectionViewController
            collectionViewController.game = game
        }
    }
}

