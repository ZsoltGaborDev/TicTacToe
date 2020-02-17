//
//  Game.swift
//  TicTacToe
//
//  Created by zsolt on 01/07/2019.
//  Copyright © 2018 Olga Volkova OC. All rights reserved.
//

import Foundation

class Game {
    private var board = Board()
    private var nextCard = Card.cross
    
    var nextPlayer: Player {
        return nextCard == .zero ? .two : .one
    }
    
    var isOver: Bool {
        return board.isFull || winner != nil
    }
    
    var winningIndices: [Int]? {
        return board.winningIndices
    }
    
    var winner: Player? {
        if let winningCardState = board.winningCardState {
            return winningCardState == .zero ? .two : .one
        }
        return nil
    }
    
    func advance(atIndex index: Int) -> String? {
        let currentCard = nextCard
        board.mark(card: currentCard, at: index)
        nextCard = currentCard == .cross ? .zero : .cross
        return currentCard.title()
    }
    
}


