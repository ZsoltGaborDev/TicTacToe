//
//  ViewController.swift
//  TicTacToe
//
//  Created by zsolt on 01/07/2019.
//  Copyright © 2018 Olga Volkova OC. All rights reserved.
//

import UIKit


@available(iOS 13.0, *)
class ViewController: UIViewController {
    
    @IBOutlet var board: [UIButton]!
    
    @IBOutlet weak var nextTurnPlayer1Label: UILabel!
    @IBOutlet weak var nextTurnPlayer2Label: UILabel!
    
    @IBOutlet weak var nextTurnPlayer1Panel: UIView!
    @IBOutlet weak var nextTurnPlayer2Panel: UIView!
    @IBOutlet weak var scorePlayer1Label: UILabel!
    @IBOutlet weak var scorePlayer2Label: UILabel!
    var nextPlayerColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1)
    var winnerColor = UIColor.systemTeal
    
    var tournament = Tournament()
    var game = Game()
    var singlePlayer = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newGame()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkSinglePlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startOverButtonPress(_ sender: Any) {
        newGame()
    }
    @IBAction func cardButtonPress(_ sender: UIButton) {
        if let index = board.firstIndex(of: sender) {
            let cardTitle = game.advance(atIndex: index)
            markBoardCard(withTitle: cardTitle, at: index)
            if game.isOver {
                if let winningIndices = game.winningIndices {
                    for temp in 0 ..< winningIndices.count {
                        board[winningIndices[temp]].backgroundColor = winnerColor
                    }
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
                        self.presentWinner() })
                } else {
                    presentWinner() }
            } else {
                setNextPlayer()
                if singlePlayer == true {
                    playRobot()
                    if game.isOver {
                        if let winningIndices = game.winningIndices {
                            for temp in 0 ..< winningIndices.count {
                                board[winningIndices[temp]].backgroundColor = winnerColor
                            }
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
                                self.presentWinner() })
                        } else {
                            presentWinner() }
                    }
                }
            }
        }
    }
    func checkSinglePlayer() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds
        self.view.addSubview(blurVisualEffectView)
        blurVisualEffectView.isHidden = true
        let setSinglePlayer = UIAlertAction(title: "Single Player", style: .default, handler: { (_) in
            self.singlePlayer = true
            blurVisualEffectView.isHidden = true
        })
        let setMultiPlayer = UIAlertAction(title: "Multiplayer", style: .default, handler: { (_) in
            self.singlePlayer = false
            blurVisualEffectView.isHidden = true
        })
        let message = ""
        let setSinglePlayerAlert = UIAlertController(title: "Number of Players",
                                         message: message,
                                         preferredStyle: .alert)
        setSinglePlayerAlert.addAction(setSinglePlayer)
        setSinglePlayerAlert.addAction(setMultiPlayer)
        // Accessing alert view backgroundColor :
    setSinglePlayerAlert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.red
        // Accessing buttons tintcolor :
        setSinglePlayerAlert.view.tintColor = UIColor.yellow
        present(setSinglePlayerAlert, animated: true, completion: nil)
        blurVisualEffectView.isHidden = true
    }
    func playRobot() {
        let indexArray = 0 ..< board.count
        var shuffledIndexes =  indexArray.shuffled()
        for index in shuffledIndexes {
            let button = board[index]
            if button.title(for: .normal) == "" {
                let cardTitle = game.advance(atIndex: index)
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
                self.markBoardCard(withTitle: cardTitle, at: index) })
                let temp = shuffledIndexes.firstIndex(of: index)
                shuffledIndexes.remove(at: temp!)
                setNextPlayer()
                break
            }
        }
    }
    func presentWinner() {
        let okAction = UIAlertAction(title: "Play again!", style: .default, handler: { (_) in
            self.completeGame()
            self.newGame()
            self.checkSinglePlayer()
        })
        var message = "Oops, it's a draw!"
        if let winner = game.winner {
            switch winner {
            case .one: message = "Congrats PLAYER 1"
            case .two: message = "Congrats PLAYER 2"
            }
        }
        let congrats = UIAlertController(title: "Game over".uppercased(),
                                         message: message,
                                         preferredStyle: .alert)
        // Accessing alert view backgroundColor :
        congrats.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.systemGreen
        // Accessing buttons tintcolor :
        congrats.view.tintColor = UIColor.systemYellow
        congrats.addAction(okAction)
        present(congrats, animated: true, completion: nil)
    }
    func newGame() {
        setBoard()
        game = Game()
        setScore()
        setNextPlayer()
        clearBoard()
    }
    func completeGame() {
        tournament.addGame(withWinner: game.winner)
    }
    func setNextPlayer(){
        nextTurnPlayer1Label.isHidden = game.nextPlayer == .one ? false : true
        nextTurnPlayer2Label.isHidden = game.nextPlayer == .two ? false : true
        nextTurnPlayer1Panel.backgroundColor = game.nextPlayer == .one ? nextPlayerColor : .clear
        nextTurnPlayer2Panel.backgroundColor = game.nextPlayer == .two ? nextPlayerColor : .clear
    }
    func setScore() {
        scorePlayer1Label.text = "\(tournament.score(forPlayer: .one))"
        scorePlayer2Label.text = "\(tournament.score(forPlayer: .two))"
    }
    func setBoard() {
        for temp in 0 ..< board.count {
            markBoardCard(withTitle: nil, at: temp)
        }
    }
    func markBoardCard(withTitle title: String?, at index: Int) {
        let button = board[index]
        button.setTitle(title, for: .normal)
        button.isEnabled = title == nil
        button.backgroundColor = .white
        if title == "X" {
            button.setTitleColor(.systemRed, for: .normal)
        } else {
            button.setTitleColor(.systemGreen, for: .normal)
        }
    }
    func clearBoard() {
        for temp in 0 ..< board.count {
            board[temp].setTitle("", for: .normal)
            board[temp].backgroundColor = .white
        }
    }
}
