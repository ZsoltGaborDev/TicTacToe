//
//  GameTestCase.swift
//  TicTacToeTests
//
//  Created by zsolt on 01/07/2019.
//  Copyright © 2019 Olga Volkova OC. All rights reserved.
//

import XCTest
@testable import TicTacToe

class GameTestCase: XCTestCase {

    var game: Game!
    
    override func setUp() {
        super.setUp()
        game = Game()
    }
    
    enum WinningVariant {
        case row, column, diagonalOne, diagonalTwo
    }
    
    func makeWinningIndices(player: Player, variant: WinningVariant) -> [Int] {
        switch variant {
        case .row: return player == .one ? [0, 7, 1, 8, 2] : [6, 0, 7, 1, 8, 2]
        case .column: return player == .one ? [0, 1, 3, 5, 6] : [7, 0, 1, 3, 5, 6]
        case .diagonalOne: return player == .one ? [0, 1, 4, 5, 8] : [7, 0, 1, 4, 5, 8]
        case .diagonalTwo: return player == .one ? [2, 1, 4, 5, 6] : [7, 2, 1, 4, 5, 6]
        }
    }
    
    func makeDrawIndices() -> [Int] {
        return [0, 3, 6, 2, 5, 8, 1, 4, 7]
    }
    
    func advance(indices: [Int]) {
        for i in 0 ..< indices.count {
            _ = game.advance(atIndex: indices[i])
        }
    }
    
    func testGivenGameIsAtStart_WhenAdvanced_ThenShouldBeMarkedWithXAndNextPlayerTwo() {
        let title = game.advance(atIndex: 0)
        
        XCTAssertEqual(title, "X")
        XCTAssertEqual(game.nextPlayer, .two)
    }
    
    func testGivenGameIsAtStart_WhenAdvancedWithCrossesInRowOne_ThenGameShouldBeOverWithWinnerAsPlayerOneAndWinningIndicesNotNil() {
        
        advance(indices: makeWinningIndices(player: .one, variant: .row))
        
        XCTAssertTrue(game.isOver)
        XCTAssertEqual(game.winner, .one)
        XCTAssertNotNil(game.winningIndices)
    }
    
    func testGivenGameIsAtStart_WhenAdvancedWithZerosInRowOne_ThenGameShouldBeOverWithWinnerAsPlayerTwoAndWinningIndicesNotNil() {
        
        advance(indices: makeWinningIndices(player: .two, variant: .row))
        
        XCTAssertTrue(game.isOver)
        XCTAssertEqual(game.winner, .two)
        XCTAssertNotNil(game.winningIndices)
    }
    
    func testGivenGameIsAtStart_WhenAdvancedWithCrossesInColumnOne_ThenWinnerShouldBeNotNil() {
        
        advance(indices: makeWinningIndices(player: .two, variant: .column))
        
        XCTAssertNotNil(game.winner)
    }
    
    func testGivenGameIsAtStart_WhenAdvancedWithCrossesInDiagonalOne_ThenWinnerShouldBeNotNil() {
        
        advance(indices: makeWinningIndices(player: .two, variant: .diagonalOne))
        
        XCTAssertNotNil(game.winner)
    }
    
    func testGivenGameIsAtStart_WhenAdvancedWithCrossesInDiagonalTwo_ThenWinnerShouldBeNotNil() {
        
        advance(indices: makeWinningIndices(player: .two, variant: .diagonalTwo))
        
        XCTAssertNotNil(game.winner)
    }
    
    func testGivenGameIsAtStart_WhenAdvancedToFill_ThenGameShouldBeOverWithWinnerAsNilAndWinningIndicesAsNil() {
        
        advance(indices: makeDrawIndices())
        
        XCTAssertTrue(game.isOver)
        XCTAssertNil(game.winner)
        XCTAssertNil(game.winningIndices)
    }

}
