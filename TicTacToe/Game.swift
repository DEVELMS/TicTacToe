//
//  Game.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 17/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

protocol Gaming: AnyObject {
    
    var game: Game { get set }
    
    func finishedGame(state: GameState.FinishedState)
}

enum GameState {
    
    case progress(state: Bool)
    case finished(finishedState: FinishedState)
    
    enum FinishedState {
        case win(player: Player)
        case draw
    }
}

struct Game {

    private var players = [Player]()
    private var actualPlayer: Player?
    private var gameState = GameState.progress(state: true)
    private var lastMovement: Movement?
    var delegate: Gaming!
    var field: Field
    
    init() { self.field = Field() }
    
    mutating func start() {
        
        players.append(Player(name: "Lightsabers", playerType: Player.PlayerType.playerOne))
        players.append(Player(name: "Death Star", playerType: Player.PlayerType.playerTwo))
        
        actualPlayer = players.first
    }
    
    mutating func restart() {
        
        gameState = GameState.progress(state: true)
        field.cleanPositions()
    }
    
    mutating func play(position: Int) -> Bool {
        
        guard let player = actualPlayer else {
            print("players not initialized")
            return false
        }
        
        guard field.checkFieldPositions(movement: Movement(player: player, position: position)) else {
            print("movement not allowed")
            self.setGameState(gameState: .progress(state: false))
            return false
        }
        
        lastMovement = Movement(player: player, position: position)
        actualPlayer = getNextPlayer(previousPlayer: player)
        
        self.setGameState(gameState: .progress(state: true))
        checkVictory(player: lastMovement!.player)
        
        return true
    }
    
    private mutating func checkVictory(player: Player) {
        
        let movementType = Movement.MovementType(player: player)
        
        //Linha 1
        let l1 = field.checkPositions(position: Position(position: 0, movementType: movementType)) &&
                 field.checkPositions(position: Position(position: 1, movementType: movementType)) &&
                 field.checkPositions(position: Position(position: 2, movementType: movementType))
        //Linha 2
        let l2 = field.checkPositions(position: Position(position: 3, movementType: movementType)) &&
                 field.checkPositions(position: Position(position: 4, movementType: movementType)) &&
                 field.checkPositions(position: Position(position: 5, movementType: movementType))
        //Linha 3
        let l3 = field.checkPositions(position: Position(position: 6, movementType: movementType)) &&
                 field.checkPositions(position: Position(position: 7, movementType: movementType)) &&
                 field.checkPositions(position: Position(position: 8, movementType: movementType))
        //Coluna 1
        let c1 = field.checkPositions(position: Position(position: 0, movementType: movementType)) &&
                 field.checkPositions(position: Position(position: 3, movementType: movementType)) &&
                 field.checkPositions(position: Position(position: 6, movementType: movementType))
        //Coluna 2
        let c2 = field.checkPositions(position: Position(position: 1, movementType: movementType)) &&
                 field.checkPositions(position: Position(position: 4, movementType: movementType)) &&
                 field.checkPositions(position: Position(position: 7, movementType: movementType))
        //Coluna 3
        let c3 = field.checkPositions(position: Position(position: 2, movementType: movementType)) &&
                 field.checkPositions(position: Position(position: 5, movementType: movementType)) &&
                 field.checkPositions(position: Position(position: 8, movementType: movementType))
        //Diagonal 1
        let d1 = field.checkPositions(position: Position(position: 0, movementType: movementType)) &&
                 field.checkPositions(position: Position(position: 4, movementType: movementType)) &&
                 field.checkPositions(position: Position(position: 8, movementType: movementType))
        //Diagonal 2
        let d2 = field.checkPositions(position: Position(position: 2, movementType: movementType)) &&
                 field.checkPositions(position: Position(position: 4, movementType: movementType)) &&
                 field.checkPositions(position: Position(position: 6, movementType: movementType))
        
        if  l1 || l2 || l3 || c1 || c2 || c3 || d1 || d2 {
            self.setGameState(gameState: GameState.finished(finishedState: .win(player: player)))
        }
        else if field.getPositions().count == field.maxPositions {
            self.setGameState(gameState: GameState.finished(finishedState: .draw))
        }
    }
    
    mutating func setGameState(gameState: GameState) {
        
        self.gameState = gameState
        
        switch self.gameState {
            
        case GameState.finished(finishedState: .win(let winner)):
            
            if var player1 = getPlayers().first, winner.playerType == player1.playerType {
                player1.addWin()
                players.remove(at: 0)
                players.insert(player1, at: 0)
            }
            else if var player2 = getPlayers().last, winner.playerType == player2.playerType {
                player2.addWin()
                players.remove(at: 1)
                players.insert(player2, at: 1)
            }
            delegate.finishedGame(state: .win(player: winner))
            
        case GameState.finished(finishedState: .draw):
            delegate.finishedGame(state: .draw)
            
        default: break
        }
    }
    
    func getPlayers() -> [Player] {
        
        return players
    }
    
    func getNextPlayer(previousPlayer: Player) -> Player {
        
        if previousPlayer.playerType == players.first?.playerType {
            return getPlayers().last!
        }
        else {
            return getPlayers().first!
        }
    }
    
    func getLastMovementType() -> Movement.MovementType {
        
        return lastMovement!.movementType
    }
}
