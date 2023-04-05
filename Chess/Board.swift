//
//  Board.swift
//  Chess
//
//  Created by H.Namikawa on 2023/04/04.
//

import Foundation

class Board {
  
  // first idea
  var playBoard:[[Piece?]] = [[]]
  
  var gameState:GameState = .ongoing
  var player:Player = .white
  
  var whiteTurnCount = 0
  var blackTurnCount = 0
  var whiteWinCount = 0
  var blackWinCount = 0
  
  init(gameState: GameState, player: Player, whiteCount: Int = 0, blackCount: Int = 0) {
    self.gameState = gameState
    self.player = player
    self.whiteTurnCount = whiteCount
    self.blackTurnCount = blackCount
    
    var P = Pawn(isWhite: true)
    var K = Knight(isWhite: true)
    var B = Bishop(isWhite: true)
    var R = Rook(isWhite: true)
    var Q = Queen(isWhite: true)
    var G = King(isWhite: true)
    var p = Pawn(isWhite: false)
    var k = Knight(isWhite: false)
    var b = Bishop(isWhite: false)
    var r = Rook(isWhite: false)
    var q = Queen(isWhite: false)
    var g = King(isWhite: false)
    
    self.playBoard = [[R, K, B, G, Q, B, K, R],
                      [P, P, P, P, P, P, P, P],
                      [nil, nil, nil, nil, nil, nil, nil, nil],
                      [nil, nil, nil, nil, nil, nil, nil, nil],
                      [nil, nil, nil, nil, nil, nil, nil, nil],
                      [nil, nil, nil, nil, nil, nil, nil, nil],
                      [p, p, p, p, p, p, p, p],
                      [r, k, b, g, q, b, k, r]]
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
    for (i, row) in self.playBoard.enumerated() {
      for (j, piece) in row.enumerated() {
        if piece != nil {
          print(piece!.symbol, terminator: " ")
        } else {
          print(".", terminator: " ")
        }
      }
      print(" " + String(8 - i))
    }
    print()
    print("a b c d e f g h")
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
  
  func judgeGameState() {
    
  }
}

enum Player {
  case black, white
}

enum GameState: String {
    case ongoing, check, checkmate, stalemate, draw
}
