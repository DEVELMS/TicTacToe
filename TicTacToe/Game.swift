//
//  Game.swift
//  TicTacToe
//
//  Created by Lucas M Soares on 17/10/16.
//  Copyright © 2016 Lucas M Soares. All rights reserved.
//

struct Game {

    private var players = [Player]()
    private var actualPlayer: Player?
    private var gameState = GameState.progress
    private var gameType: GameType?
    private var lastMovement: Movement?
    var field: Field = Field()
    var delegate: Gaming?
    
    enum GameType {
        
        case cpu
        case pvp(players: [Player])
    }
    
    enum GameState {
        
        case progress
        case finished(finishedState: FinishedState)
        
        enum FinishedState {
            
            case win(player: Player)
            case draw
        }
    }
    
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
            players.append(Player(name: "Você", playerType: Player.PlayerType.playerOne, human: true))
            players.append(Player(name: "Death Star", playerType: Player.PlayerType.playerTwo, human: false))
            
        case .pvp(let players):
            self.players = players
        }
        
        actualPlayer = players.first
    }
    
    mutating func restart() {
        
        guard let gameType = gameType else {
            print("game type not selected")
            return
        }
        
        gameState = GameState.progress
        field.cleanPositions()
        
        switch gameType {
        case .cpu:
            actualPlayer = players.first
        default:
            break
        }
    }
    
    mutating func play(position: Int? = nil, movement: Movement? = nil) -> Bool {
        
        guard let delegate = delegate else {
            print("game delegate did not setted to play")
            return false
        }
        
        guard let player = actualPlayer else {
            print("player not initialized")
            return false
        }
        
        guard let gameType = gameType else {
            print("game type not selected")
            return false
        }
        
        if let position = position {
        
            guard field.checkFieldPositions(movement: Movement(player: player, position: position)) else {
                return false
            }
            
            lastMovement = Movement(player: player, position: position)
            
            guard !checkVictory(player: lastMovement!.player) else {
                return true
            }
        }
        else if let movement = movement {
            
            guard field.checkFieldPositions(movement: movement) else {
                print("cpu movement invalid")
                return false
            }
            
            guard !checkVictory(player: movement.player) else {
                return true
            }
        }
        
        actualPlayer = getNextPlayer(previousPlayer: player)
        
        switch gameType {
        case .cpu:
            
            guard let actualPlayer = actualPlayer else { return false }
            
            if let cpu = players.last, !cpu.human, cpu.playerType == actualPlayer.playerType {
                
                guard let movement = cpu.doMovement(at: field) else { return false }
                delegate.cpuPlayed(movement: movement)
            }
            
        case .pvp(_): delegate.activePlayer(activePlayer: actualPlayer!)
        }
        
        return true
    }
    
    private mutating func checkVictory(player: Player) -> Bool {
        
        let movementType = Movement.MovementType(player: player)
        
        var victory = Bool()
        
        for positions in Field.positionstoWin {
            
            for (index, position) in positions.enumerated() {
                
                if(!field.checkPositions(position: Position(position: position, movementType: movementType))) { break }
                else if (index == (positions.count - 1)) {
                    victory = true
                }
            }
            if victory { break }
        }
        
        if victory {
            setGameState(gameState: GameState.finished(finishedState: .win(player: player)))
            return true
        }
        else if field.getPositions().count == Field.maxPositions {
            setGameState(gameState: GameState.finished(finishedState: .draw))
            return true
        }
        
        return false
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
                players[index].winned()
            }
            delegate.finishedGame(state: .win(player: winner))
            
        case GameState.finished(finishedState: .draw):
            delegate.finishedGame(state: .draw)
            
        default: break
        }
    }
    
    func getLastMovementType() -> Movement.MovementType? {
        guard let movementType = lastMovement?.movementType else { return nil }
        return movementType
    }
    
    func getPlayers() -> [Player] {
        
        return players
    }
    
    private func getNextPlayer(previousPlayer: Player) -> Player {
        
        for player in players {
            if player.playerType != previousPlayer.playerType {
                return player
            }
        }
        assert(false, "getNextPlayer(nenhum player disponível)")
    }
}
