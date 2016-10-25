//
//  CollectionViewController.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 15/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, Gaming {
    
    var game: Game!
    var header = CollectionViewHeader()
    var footer = CollectionViewFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionViewLayout()
        gameConfigs()
    }
    
    func gameConfigs() {
        
        game.delegate = self
        game.start()
    }
    
    func setCollectionViewLayout() {
        
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        let screenSize: CGRect = UIScreen.main.bounds
        
        let cellWidth = screenSize.width / 3 - 1
        var cellHeight =  CGFloat()
        
        if let layout = layout, layout.headerReferenceSize.height > 0 {
            
            cellHeight = (screenSize.height - layout.headerReferenceSize.height - layout.footerReferenceSize.height) / 3 - 1
        }
        else { cellHeight = screenSize.height / 3 - 1 }
        
        layout?.itemSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    func showResult(title: String, message: String? = "") {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Começar outra partida", style: .destructive, handler: {
            action in
            
            self.game.restart()
            self.collectionView?.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateVictories() {
    
        for player in game.getPlayers() {
            footer.updateVictories(player: player)
        }
    }
    
    // MARK: Gaming
    
    func finishedGame(state: GameState.FinishedState) {
        
        switch state {
            
        case .win(let winner):
            showResult(title: "\(winner.name) é o vencedor!")
            updateVictories()
        case .draw:
            showResult(title: "Empate!")
            footer.updateDrawns()
        }
    }
    
    func activePlayer(activePlayer: Player) {
        
        header.setTitle(name: activePlayer.name)
    }
    
    func turnOff() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func cpuPlayed(movement: Movement) {
        
        let indexPath = IndexPath(row: movement.position.position, section: 0)
        
        if game.play(movement: movement) {
            let cell = self.collectionView!.cellForItem(at: indexPath) as! CollectionViewCell
            cell.setItem(type: movement.movementType)
        } else { print("cpu cannot play") }
    }
    
    func setUserInteraction(booleano: Bool) {
        self.collectionView!.isUserInteractionEnabled = booleano
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewHeader.identifier, for: indexPath) as! CollectionViewHeader
            header.delegate = self
            
            if let player = game.getPlayers().first {
                header.setTitle(name: player.name)
            } else { header.setTitle(name: "Ops!") }
            
            return header
            
        case UICollectionElementKindSectionFooter:
            
            footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewFooter.identifier, for: indexPath) as! CollectionViewFooter
            
            updateVictories()
            
            return footer
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return game.field.maxPositions
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        cell.setItem()
        
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
