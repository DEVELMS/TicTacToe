//
//  Game.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 17/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

enum GameType {
    
    case cpu
    case pvp(players: [Player])
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
    private var gameType: GameType?
    private var lastMovement: Movement?
    lazy var field: Field = Field()
    var delegate: Gaming?
    
    mutating func start() {
        
        guard delegate != nil else {
            print("game delegate did not setted to start")
            return
        }
        
        guard let gameType = gameType else {
            print("game type not selected")
            return
        }
        
        switch gameType {
            
        case .cpu:
            players.append(Player(name: "Você", playerType: Player.PlayerType.playerOne))
            players.append(Player(name: "Death Star", playerType: Player.PlayerType.playerTwo))
            
        case .pvp(let players):
            self.players = players
        }
        
        actualPlayer = players.first
    }
    
    mutating func restart() {
        
        gameState = GameState.progress(state: true)
        field.cleanPositions()
    }
    
    mutating func play(position: Int) -> Bool {
        
        guard let delegate = delegate else {
            print("game delegate did not setted to play")
            return false
        }
        
        guard let player = actualPlayer else {
            print("player not initialized")
            return false
        }
        
        guard field.checkFieldPositions(movement: Movement(player: player, position: position)) else {
            print("movement not allowed")
            setGameState(gameState: .progress(state: false))
            return false
        }
        
        lastMovement = Movement(player: player, position: position)
        actualPlayer = getNextPlayer(previousPlayer: player)
        delegate.activePlayer(activePlayer: actualPlayer!)
        setGameState(gameState: .progress(state: true))
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
            setGameState(gameState: GameState.finished(finishedState: .win(player: player)))
        }
        else if field.getPositions().count == field.maxPositions {
            setGameState(gameState: GameState.finished(finishedState: .draw))
        }
    }
    
    mutating func setGameType(gameType: GameType) {
        
        self.gameType = gameType
    }
    
    private mutating func setGameState(gameState: GameState) {
        
        self.gameState = gameState
        
        guard let delegate = delegate else {
            print("game delegate did not setted")
            return
        }
        
        switch self.gameState {
            
        case GameState.finished(finishedState: .win(let winner)):
            
            for (index, player) in players.enumerated() where player.playerType == winner.playerType {
                players[index].addWin()
            }
            delegate.finishedGame(state: .win(player: winner))
            
        case GameState.finished(finishedState: .draw):
            delegate.finishedGame(state: .draw)
            
        default: break
        }
    }
    
    func getLastMovementType() -> Movement.MovementType {
        
        return lastMovement!.movementType
    }
    
    func getPlayers() -> [Player] {
        
        return players
    }
    
    private func getNextPlayer(previousPlayer: Player) -> Player {
        
        if previousPlayer.playerType == players.first?.playerType {
            return getPlayers().last!
        }
        else {
            return getPlayers().first!
        }
    }
}
