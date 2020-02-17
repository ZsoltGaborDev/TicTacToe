//
//  TurnamentTestCase.swift
//  TicTacToeTests
//
//  Created by zsolt on 15/07/2019.
//  Copyright © 2019 Olga Volkova OC. All rights reserved.
//

import XCTest
@testable import TicTacToe

class TournamentTestCase:  XCTestCase {
    
    var tournament: Tournament!
    
    override func setUp() {
        
        super.setUp()
        tournament = Tournament()
    }
    
    func addGames(_ count: Int, withWinner winner: Player?) {
        for _ in 0 ..< count {
            tournament.addGame(withWinner: winner)
        }
    }
    
    func testGivenGameWonByPlayerOneForThirdTime_WhenAdded_ThenScoreShouldBe6x0() {
        addGames(3, withWinner: .one)
        
        XCTAssertEqual(tournament.score(forPlayer: .one), 6)
        XCTAssertEqual(tournament.score(forPlayer: .two), 0)
    }
    
    func testGivenGameWonByPlayerOneFollowing3WinsPlayerOneAndDraw_WhenAdded_ThenScoreShouldBe7x0() {
        addGames(3, withWinner: .one)
        addGames(1, withWinner: nil)
        addGames(1, withWinner: .one)
        
        XCTAssertEqual(tournament.score(forPlayer: .one), 7)
        XCTAssertEqual(tournament.score(forPlayer: .two), 0)
    }
    
    func testGivenDrawGameFollowing3WinsPlayer13WinsPlayer2And2Draws_WhenAdded_ThenScoreShouldBe0x0() {
        addGames(3, withWinner: .one)
        addGames(3, withWinner: .two)
        addGames(3, withWinner: nil)
        
        XCTAssertEqual(tournament.score(forPlayer: .one), 0)
        XCTAssertEqual(tournament.score(forPlayer: .two), 0)
    }
    
}
