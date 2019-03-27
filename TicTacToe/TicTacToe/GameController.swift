//
//  GameController.swift
//  TicTacToe
//
//  Created by Robert Herley on 3/15/19.
//  Copyright © 2019 Robert Herley. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet var tiles: [UIButton]?
    @IBOutlet weak var newGameButton: UIButton!
    
    // Annoyed that UI color cannot be in enum
    enum Player : String {
        case One = "⨉"
        case Two = "○"
        case None = ""
    }
    
    var turn = Player.One
    var winner : Player?
    var playerOne = "Nobody"
    var playerTwo = "Nobody"
    
    func getPlayerColor(player : Player) -> UIColor {
        switch player {
        case .One:
            return #colorLiteral(red: 0.6366271377, green: 0.7485631108, blue: 0.5405669212, alpha: 1)
        case .Two:
            return #colorLiteral(red: 0.5254320502, green: 0.7524794936, blue: 0.8199318051, alpha: 1)
        case .None:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    func setTurn(to newTurn : Player){
        turnLabel.text = "\(newTurn == .One ? playerOne : playerTwo)'s Turn"
        turnLabel.textColor = getPlayerColor(player: newTurn)
        turn = newTurn
    }
    
    // I know there's a better way, but I'm lazy today
    func checkEndGame() {
        let values = tiles!.map({ tile in Player(rawValue: tile.titleLabel!.text ?? "" )! })
        
        func checkWinner(p player : Player) {
            if(player != .None){
                winner = player
            }
        }
        
        // row
        if(values[0] == values[1] && values[1] == values[2]){
            checkWinner(p: values[0])
        }
        if (values[3] == values[4] && values[4] == values[5]){
            checkWinner(p: values[3])
        }
        if(values[6] == values[7] && values[7] == values[8]){
            checkWinner(p: values[6])
        }
        
        // column
        if(values[0] == values[3] && values[3] == values[6]){
            checkWinner(p: values[0])
        }
        if(values[1] == values[4] && values[4] == values[7]) {
            checkWinner(p: values[1])
        }
        if(values[2] == values[5] && values[5] == values[8]){
            checkWinner(p: values[2])
        }
        
        //diag
        if(values[0] == values[4] && values[4] == values[8]){
            checkWinner(p: values[0])
        }
        if(values[2] == values[4] && values[4] == values[6]){
            checkWinner(p: values[2])
        }
        
        // Check num of tiles
        let placedTiles = values.reduce(0, { $0 + ($1.rawValue == "" ? 0 : 1 )})
        if(placedTiles == 9){
            // stalemate
            winner = .None
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTurn(to: .One)
        newGameButton.isHidden = true
    }
    
    @IBAction func pressTile(_ sender: UIButton) {
        if (sender.titleLabel!.text == nil) && (winner == nil) {
            let tileIndex = tiles!.index(of: sender)!
            let tile = tiles![tileIndex]
            tile.setTitle(turn.rawValue, for: .normal)
            tile.setTitleColor(getPlayerColor(player: turn), for: .normal)
            setTurn(to: turn == .One ? .Two : .One)
            checkEndGame()
            if winner != nil {
                turnLabel.textColor = getPlayerColor(player: winner!)
                if(winner == .None){
                    turnLabel.text = "It's a tie!"
                } else {
                    turnLabel.text = "\(winner == .One ? playerOne : playerTwo) Won!"
                }
                newGameButton.isHidden = false
            }
        }
    }
}
