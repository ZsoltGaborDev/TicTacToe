//
//  Board.swift
//  TicTacToe
//
//  Created by zsolt on 01/07/2019.
//  Copyright © 2018 Olga Volkova OC. All rights reserved.
//

import Foundation

class Board {
    
    private static var gridSize = 3
    private var cards:[Card?] = Array(repeating: nil, count: Board.gridSize * Board.gridSize)
    
    var isFull: Bool {
        return cards.filter { $0 != nil }.count == cards.count
    }
    
    var winningCardState: Card? {
        if let indices = winningIndices {
            return cards[indices[0]]
        }
        return nil
    }
    
    var winningIndices: [Int]? {
        var indices = [Int]()
        var ind: Int
        var referenceCard: Card?
        let gridSize = Board.gridSize
        //horizontal
        for i in 0 ..< gridSize {
            indices.removeAll()
            ind = i * gridSize + 0
            
            referenceCard = cards[ind]
            if referenceCard == nil {
                continue
            }
            indices.append(ind)
            var win = true
            for j in 1 ..< gridSize {
                ind = i * Board.gridSize + j
                if cards[ind] != referenceCard {
                    win = false
                    break
                }
                indices.append(ind)
            }
            if win {
                return indices
            }
        }
        
        //vertical
        for j in 0 ..< gridSize {
            indices.removeAll()
            ind = j
            referenceCard = cards[ind]
            if referenceCard == nil {
                continue
            }
            indices.append(ind)
            var win = true
            for i in 1 ..< gridSize {
                ind = i * gridSize + j
                if cards[ind] != referenceCard {
                    win = false
                    break
                }
                indices.append(ind)
            }
            if win {
                return indices
            }
        }
        
        //diagonal 1
        indices.removeAll()
        ind = 0
        referenceCard = cards[0]
        indices.append(ind)
        if referenceCard != nil {
            var j = 1
            var win = true
            for i in 1 ..< gridSize {
                ind = gridSize * i + j
                if cards[ind] != referenceCard {
                    win = false
                    break
                }
                j += 1
                indices.append(ind)
            }
            if win {
                return indices
            }
        }
        
        //diagonal 2
        indices.removeAll()
        ind = gridSize - 1
        referenceCard = cards[ind]
        indices.append(ind)
        if referenceCard != nil {
            var j = gridSize - 2
            var win = true
            for i in 1 ..< gridSize {
                ind = gridSize * i + j
                if cards[ind] != referenceCard {
                    win = false
                    break
                }
                j -= 1
                indices.append(ind)
            }
            if win {
                return indices
            }
        }
        return nil
    }
    
    func mark(card: Card, at index: Int) {
        cards[index] = card
    }
}
