//
//  Board.swift
//  Chess
//
//  Created by H.Namikawa on 2023/04/04.
//

import Foundation

class Board {
  
  // first idea
  var playBoard:[Position:Piece?] = [Position(row: 1, column: 1):nil]
  // 
  
  var gameState:GameState = .ongoing
  var player:Player = .white
  
  var whiteCount = 0
  var blackCount = 0
  
  init(gameState: GameState, player: Player, whiteCount: Int = 0, blackCount: Int = 0) {
    self.gameState = gameState
    self.player = player
    self.whiteCount = whiteCount
    self.blackCount = blackCount
  }
  
  // show the board like
  //♜ ♞ ♝ . ♚ ♝ ♞ ♜  8
  //♟ ♟ ♟ . . ♟ ♟ ♟  7
  //. . . . ♟ . . .  6
  //. . . ♙ . . . .  5
  //♙ . . . ♛ . . .  4
  //. . . . . . . .  3
  //. ♙ ♙ ♙ ♘ ♙ ♙ ♙  2
  //♖ . ♗ ♕ ♔ ♗ ♘ ♖  1
  //a b c d e f g h
  func displayBoard() {
    
  }
  
  /// find possible move
  func findPossibleMove() -> [Position:[Position]] {
    return [Position(row: 1, column: 1):[]]
  }
  
  /// find possible moves for one piece
  func findPossibleMove(tgt:Piece) {
    
  }
  
  /// move a piece
  func move(piece:Piece, to:Position){
    
  }
  
  func switchPlayer(){
    
  }
}

enum Player {
  case black, white
}

enum GameState: String {
    case ongoing, check, checkmate, stalemate, draw
}
