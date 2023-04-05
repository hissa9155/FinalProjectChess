//
//  Board.swift
//  Chess
//
//  Created by H.Namikawa on 2023/04/04.
//

import Foundation

class Board {
  
  static let MIN_ROW_NUM = 0
  static let MIN_COL_NUM = 0
  static let MAX_ROW_NUM = 7
  static let MAX_COL_NUM = 7
  
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
    
    self.playBoard = [[r, k, b, g, q, b, k, r],
                      [p, p, p, p, p, p, p, p],
                      [nil, nil, nil, nil, nil, nil, nil, nil],
                      [nil, nil, nil, nil, nil, nil, nil, nil],
                      [nil, nil, nil, nil, nil, nil, nil, nil],
                      [nil, nil, nil, nil, nil, nil, nil, nil],
                      [P, P, P, P, P, P, P, P],
                      [R, K, B, G, Q, B, K, R],]
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
  func findPossibleMoves() -> [Position:[Position]] {
    
    var possibleMovesDic:[Position:[Position]] = Dictionary()
    
    for (_, row) in playBoard.enumerated() {
      for (_, piece) in row.enumerated() {
        if piece == nil {
          continue
        }
        var _piece = piece!
        
        var _possibleMoves = self.findPossibleMoves(tgt: _piece)
        possibleMovesDic[_piece.position] = _possibleMoves
      }
    }
    
    return possibleMovesDic
  }
  
  /// find possible moves for one piece
  func findPossibleMoves(tgt:Piece) -> [Position] {
    var possibleMoves:[Position] = []
    
    switch tgt.role {
    // King, Knight
    case .king, .knight:
      var _possibleMoves = tgt.getPossibleMoves()
      for position in _possibleMoves {
        if !friendExistsOnPosition(position: position) {
          possibleMoves.append(position)
        }
      }
    // Queen, Bishop, Rook
    case .queen, .bishop, .rook:
      let row = tgt.position.row
      let col = tgt.position.column
      
      if tgt.role == .queen || tgt.role == .rook {
        // verticle line
        for rowNum in Board.MIN_ROW_NUM...Board.MAX_ROW_NUM {
          if rowNum == row {
            continue
          }
          if friendExistsOnPosition(position: tgt.position){
            break
          } else {
            possibleMoves.append(Position(row: rowNum, column: col))
            if pieceExistsOnPosition(position: tgt.position) {
              break
            }
          }
        }
        // horizontal line
        for colNum in Board.MIN_COL_NUM...Board.MAX_COL_NUM {
          if colNum == col {
            continue
          }
          if friendExistsOnPosition(position: tgt.position){
            break
          } else {
            possibleMoves.append(Position(row: row, column: colNum))
            if pieceExistsOnPosition(position: tgt.position) {
              break
            }
          }
        }
      }
      
      if tgt.role == .queen || tgt.role == .bishop {
        // diagonally line
        var rowNum = row + 1
        var rightColNum = col
        var leftColNum = col
        var colDif = 0
        while rowNum <= Board.MAX_ROW_NUM {
          colDif += 1
          rightColNum += colDif
          leftColNum -= colDif
          
          if rightColNum <= Board.MAX_COL_NUM {
            if friendExistsOnPosition(position: tgt.position){
              break
            } else {
              possibleMoves.append(Position(row: rowNum, column: rightColNum))
              if pieceExistsOnPosition(position: tgt.position) {
                break
              }
            }
          }
          if leftColNum >= Board.MIN_COL_NUM {
            if friendExistsOnPosition(position: tgt.position){
              break
            } else {
              possibleMoves.append(Position(row: rowNum, column: leftColNum))
              if pieceExistsOnPosition(position: tgt.position) {
                break
              }
            }
          }
          rowNum += 1
        }
        rowNum = row - 1
        rightColNum = col
        leftColNum = col
        colDif = 0
        while rowNum >= Board.MIN_ROW_NUM {
          colDif += 1
          rightColNum += colDif
          leftColNum -= colDif
          
          if rightColNum <= Board.MAX_COL_NUM {
            if friendExistsOnPosition(position: tgt.position){
              break
            } else {
              possibleMoves.append(Position(row: rowNum, column: rightColNum))
              if pieceExistsOnPosition(position: tgt.position) {
                break
              }
            }
          }
          if leftColNum >= Board.MIN_COL_NUM {
            if friendExistsOnPosition(position: tgt.position){
              break
            } else {
              possibleMoves.append(Position(row: rowNum, column: leftColNum))
              if pieceExistsOnPosition(position: tgt.position) {
                break
              }
            }
          }
          rowNum -= 1
        }
      }
      
    // Pawn
    case .pawn:
      var _possibleMoves = tgt.getPossibleMoves()
      var row = tgt.position.row
      var col = tgt.position.column
      
      if tgt.isWhite {
        var _position = Position(row: row + 1, column: col + 1)
        var __position = Position(row: row + 1, column: col - 1)
        if foeExistsOnPosition(position: _position){
          _possibleMoves.append(_position)
        }
        if foeExistsOnPosition(position: _position){
          _possibleMoves.append(__position)
        }
      } else {
        var _position = Position(row: row - 1, column: col + 1)
        var __position = Position(row: row - 1, column: col - 1)
        if foeExistsOnPosition(position: _position){
          _possibleMoves.append(_position)
        }
        if foeExistsOnPosition(position: _position){
          _possibleMoves.append(__position)
        }
      }
      possibleMoves = _possibleMoves
    default:
      break
    }
    
    return possibleMoves
  }
  
  // Hisa I will move later
  private func pieceExistsOnPosition(position:Position) -> Bool {
    var pieceExists = false
    var _piece = playBoard[position.row][position.column]
    
    if _piece != nil {
      pieceExists = true
    }
    
    return pieceExists
  }
  
  private func friendExistsOnPosition(position:Position) -> Bool {
    var friendExists = false
    var _piece = playBoard[position.row][position.column]
    
    if !pieceExistsOnPosition(position: position) {
      return false
    }
    var piece = _piece!
    if piece.isWhite && player == .white || !piece.isWhite && player == .black {
      friendExists = true
    }
    
    return friendExists
  }
  
  private func foeExistsOnPosition(position:Position) -> Bool {
    var foeExists = false
    var _piece = playBoard[position.row][position.column]
    
    if !pieceExistsOnPosition(position: position) {
      return false
    }
    var piece = _piece!
    if piece.isWhite && player != .white || !piece.isWhite && player != .black {
      foeExists = true
    }
    
    return foeExists
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
