//
//  Tournament.swift
//  TicTacToe
//
//  Created by zsolt on 01/07/2019.
//  Copyright © 2018 Olga Volkova OC. All rights reserved.
//

import Foundation

class Tournament {
    
    private var scores = [Player.one: 0, Player.two: 0]
    private var lastWinner: Player?
    private var gamesWon = 0
    private var draws = 0
    private static let maxOfDraws = 3
    
    
    func score(forPlayer player: Player) -> Int {
        return scores[player]!
    }
    
    func addGame(withWinner winner: Player?) {
        if let winner = winner {
            if lastWinner == winner {
                gamesWon += 1
                scores[winner]! += gamesWon
            }
            else {
                lastWinner = winner
                gamesWon = 1
                scores[winner]! += gamesWon
            }
        }
        else {
            lastWinner = nil
            gamesWon = 0
            
            draws += 1
            if draws == Tournament.maxOfDraws {
                resetScores()
                draws = 0
            }
        }
    }
    
    // create reset fucntion
    private func resetScores() {
        for (player, _) in scores {
            scores[player] = 0
        }
    }
    
    
}

