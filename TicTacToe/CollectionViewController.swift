//
//  CollectionViewController.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 15/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, Gaming {
    
    var game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        setCollectionViewLayout()
        gameConfigs()
    }
    
    func gameConfigs() {
        
        game.delegate = self
        game.start()
    }
    
    func setCollectionViewLayout() {
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        let cellWidth = screenSize.width / 3 - 1
        let cellHeight = screenSize.height / 3 - 1
        
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    // MARK: Gaming Protocol
    func finishedGame(state: GameState.FinishedState) {
        
        switch state {
            
        case .win(let winner):
            showResult(title: "\(winner.name) ganhou a partida!", message: "\(game.getPlayers().first!.name) \(game.getPlayers().first!.wins) vitorias\n\(game.getPlayers().last!.name): \(game.getPlayers().last!.wins) vitorias")
            
        case .draw:
            showResult(title: "Empate!", message: "\(game.getPlayers().first!.name)!.name): \(game.getPlayers().first!.wins) vitorias\n\(game.getPlayers().last!.name): \(game.getPlayers().last!.wins) vitorias")
        }
    }
    
    func showResult(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Começar outra partida", style: .destructive, handler: {
            action in
            
            self.game.restart()
            self.collectionView?.reloadData()
        }))
            
        self.present(alert, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return game.field.maxPositions
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.item.image = nil
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if game.play(position: indexPath.row) {
            
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            cell.setItem(type: game.getLastMovementType())
        }
    }
}
