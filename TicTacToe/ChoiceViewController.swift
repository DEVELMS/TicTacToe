//
//  ChoiceViewController.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 22/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import UIKit

class ChoiceViewController: UIViewController, UIPopoverPresentationControllerDelegate, Choosing, Configuring {

    // MARK: Outlets
    
    @IBOutlet weak var configButton: UIButton!
    
    // MARK: Declarations
    
    var game = Game()
    lazy var playersModal: PlayersModalViewController = PlayersModalViewController(nibName: PlayersModalViewController.identifier, bundle: nil)
    lazy var configModal: ConfigModal = ConfigModal(nibName: ConfigModal.identifier, bundle: nil)
    
    // MARK: UIViewControllerDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playersModal.delegate = self
        configModal.delegate = self
        
        setLayoutAttributes()
        Config.sharedInstance.sound.startSoundtrack()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    // MARK: Methods
    
    private func setLayoutAttributes() {
    
        configButton.tintColor = UIColor(hexadecimal: 0xF0F0F0)
    }
    
    // MARK: Actions
    
    @IBAction func chooseCPU(_ sender: UIButton) {
        
        game.setGameType(gameType: Game.GameType.cpu)
        performSegue(withIdentifier: "sgGame", sender: self)
    }
    
    @IBAction func showPlayersModal(_ sender: UIButton) {
        
        playersModal.configModal(sender);
        self.present(playersModal, animated: true, completion: nil)
    }
    
    @IBAction func showConfigModal(_ sender: UIButton) {
        
        configModal.configModal(sender);
        self.present(configModal, animated: true, completion: nil)
    }
    
    // MARK: ChoosingDelegate
    
    func pvpSelected(gameType: Game.GameType) {
        game.setGameType(gameType: gameType)
        performSegue(withIdentifier: "sgGame", sender: self)
    }
    
    // MARK: UIPopoverPresentationDelegate
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: UINavigationControllerDelegate
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "sgGame" {
            let collectionViewController = segue.destination as! CollectionViewController
            collectionViewController.game = game
        }
    }
}

