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
    
    // white
    let P0 = Pawn(isWhite: true, position: Position(square: "a2"))
    let P1 = Pawn(isWhite: true, position: Position(square: "b2"))
    let P2 = Pawn(isWhite: true, position: Position(square: "c2"))
    let P3 = Pawn(isWhite: true, position: Position(square: "d2"))
    let P4 = Pawn(isWhite: true, position: Position(square: "e2"))
    let P5 = Pawn(isWhite: true, position: Position(square: "f2"))
    let P6 = Pawn(isWhite: true, position: Position(square: "g2"))
    let P7 = Pawn(isWhite: true, position: Position(square: "h2"))
    let K0 = Knight(isWhite: true, position: Position(square: "b1"))
    let K1 = Knight(isWhite: true, position: Position(square: "g1"))
    let B0 = Bishop(isWhite: true, position: Position(square: "c1"))
    let B1 = Bishop(isWhite: true, position: Position(square: "f1"))
    let R0 = Rook(isWhite: true, position: Position(square: "a1"))
    let R1 = Rook(isWhite: true, position: Position(square: "h1"))
    let Q = Queen(isWhite: true, position: Position(square: "e1"))
    let G = King(isWhite: true, position: Position(square: "d1"))
    // black
    let p0 = Pawn(isWhite: false, position: Position(square: "a7"))
    let p1 = Pawn(isWhite: false, position: Position(square: "b7"))
    let p2 = Pawn(isWhite: false, position: Position(square: "c7"))
    let p3 = Pawn(isWhite: false, position: Position(square: "d7"))
    let p4 = Pawn(isWhite: false, position: Position(square: "e7"))
    let p5 = Pawn(isWhite: false, position: Position(square: "f7"))
    let p6 = Pawn(isWhite: false, position: Position(square: "g7"))
    let p7 = Pawn(isWhite: false, position: Position(square: "a7"))
    let k0 = Knight(isWhite: false, position: Position(square: "b8"))
    let k1 = Knight(isWhite: false, position: Position(square: "g8"))
    let b0 = Bishop(isWhite: false, position: Position(square: "c8"))
    let b1 = Bishop(isWhite: false, position: Position(square: "f8"))
    let r0 = Rook(isWhite: false, position: Position(square: "a8"))
    let r1 = Rook(isWhite: false, position: Position(square: "h8"))
    //let q = Queen(isWhite: false, position: Position(square: "e8"))
    let g = King(isWhite: false, position: Position(square: "d8"))
    
    let q = Queen(isWhite: false, position: Position(square: "e5"))
    self.playBoard = [[R0, K0, B0, G, Q, B1, K1, R1],
                      [P0, P1, P2, P3, P4, P5, P6, P7],
                      [nil, nil, nil, nil, nil, nil, nil, nil],
                      [nil, nil, nil, nil, nil, nil, nil, nil],
                      [nil, nil, nil, nil, q, nil, nil, nil],
                      [nil, nil, nil, nil, nil, nil, nil, nil],
                      [p0, p1, p2, p3, p4, p5, p6, p7],
                      [r0, k0, b0, g, nil, b1, k1, r1]]
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
      for (_, piece) in row.enumerated() {
        if piece != nil {
          print(piece!.symbol, terminator: " ")
        } else {
          print(".", terminator: " ")
        }
      }
      print(" " + String(i + 1))
    }
    print("\na b c d e f g h\n\n")
  }
  
  /// find possible move
  func findPossibleMoves() -> [Position:[Position]] {
    
    var possibleMovesDic:[Position:[Position]] = Dictionary()
    
    for (_, row) in playBoard.enumerated() {
      for (_, piece) in row.enumerated() {
        if piece == nil {
          continue
        }
        let _piece = piece!
        
        let _possibleMoves = self.findPossibleMoves(tgt: _piece)
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
      let _possibleMoves = tgt.getPossibleMoves()
      for position in _possibleMoves {
        if !friendExistsOnPosition(position: position, isWhite: tgt.isWhite) {
          possibleMoves.append(position)
        }
      }
    // Queen, Bishop, Rook
    case .queen, .bishop, .rook:
      let row = tgt.position.row
      let col = tgt.position.column
      
      if tgt.role == .queen || tgt.role == .rook {
        // verticle line
        for rowNum in row...Board.MAX_ROW_NUM {
          if rowNum == row {
            continue
          }
          if friendExistsOnPosition(position: Position(row: rowNum, column: col), isWhite: tgt.isWhite){
            break
          } else {
            possibleMoves.append(Position(row: rowNum, column: col))
            if pieceExistsOnPosition(position: Position(row: rowNum, column: col)) {
              break
            }
          }
        }
        for rowNum in (Board.MIN_ROW_NUM...row).reversed() {
          if rowNum == row {
            continue
          }
          if friendExistsOnPosition(position: Position(row: rowNum, column: col), isWhite: tgt.isWhite){
            break
          } else {
            possibleMoves.append(Position(row: rowNum, column: col))
            if pieceExistsOnPosition(position: Position(row: rowNum, column: col)) {
              break
            }
          }
        }
        // horizontal line
        for colNum in col...Board.MAX_COL_NUM {
          if colNum == col {
            continue
          }
          if friendExistsOnPosition(position: Position(row: row, column: colNum), isWhite: tgt.isWhite){
            continue
          } else {
            possibleMoves.append(Position(row: row, column: colNum))
            if pieceExistsOnPosition(position: tgt.position) {
              continue
            }
          }
        }
        for colNum in (Board.MIN_COL_NUM...col).reversed() {
          if colNum == col {
            continue
          }
          if friendExistsOnPosition(position: Position(row: row, column: colNum), isWhite: tgt.isWhite){
            continue
          } else {
            possibleMoves.append(Position(row: row, column: colNum))
            if pieceExistsOnPosition(position: tgt.position) {
              continue
            }
          }
        }
      }
      
      
      if tgt.role == .queen || tgt.role == .bishop {
        // diagonally line
        var rowNum = row + 1
        var rightColNum = col
        var leftColNum = col
        while rowNum <= Board.MAX_ROW_NUM {
          rightColNum += 1
          leftColNum -= 1
          
          if rightColNum <= Board.MAX_COL_NUM {
            if friendExistsOnPosition(position: Position(row: rowNum, column: col), isWhite:tgt.isWhite){
              break
            } else {
              possibleMoves.append(Position(row: rowNum, column: rightColNum))
              if pieceExistsOnPosition(position: Position(row: rowNum, column: col)) {
                break
              }
            }
          }
          if leftColNum >= Board.MIN_COL_NUM {
            if friendExistsOnPosition(position: Position(row: rowNum, column: col), isWhite: tgt.isWhite){
              break
            } else {
              possibleMoves.append(Position(row: rowNum, column: leftColNum))
              if pieceExistsOnPosition(position: Position(row: rowNum, column: col)) {
                break
              }
            }
          }
          rowNum += 1
        }
        rowNum = row - 1
        rightColNum = col
        leftColNum = col
        while rowNum >= Board.MIN_ROW_NUM {
          rightColNum += 1
          leftColNum -= 1
          
          if rightColNum <= Board.MAX_COL_NUM {
            if friendExistsOnPosition(position: Position(row: rowNum, column: col), isWhite: tgt.isWhite){
              break
            } else {
              possibleMoves.append(Position(row: rowNum, column: rightColNum))
              if pieceExistsOnPosition(position: Position(row: rowNum, column: col)) {
                break
              }
            }
          }
          if leftColNum >= Board.MIN_COL_NUM {
            if friendExistsOnPosition(position: Position(row: rowNum, column: col), isWhite: tgt.isWhite){
              break
            } else {
              possibleMoves.append(Position(row: rowNum, column: leftColNum))
              if pieceExistsOnPosition(position: Position(row: rowNum, column: col)) {
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
      let row = tgt.position.row
      let col = tgt.position.column
      
      if tgt.isWhite {
        
        if row + 1 <= Board.MAX_ROW_NUM && col + 1 <= Board.MAX_COL_NUM {
          let _position = Position(row: row + 1, column: col + 1)
          if foeExistsOnPosition(position: _position, isWhite:tgt.isWhite){
            _possibleMoves.append(_position)
          }
        }
        if row + 1 <= Board.MAX_ROW_NUM && col - 1 >= Board.MIN_COL_NUM {
          let _position = Position(row: row + 1, column: col - 1)
          if foeExistsOnPosition(position: _position, isWhite:tgt.isWhite){
            _possibleMoves.append(_position)
          }
        }
      } else {
        
        if row - 1 >= Board.MIN_ROW_NUM && col + 1 <= Board.MAX_COL_NUM {
          let _position = Position(row: row - 1, column: col + 1)
          if foeExistsOnPosition(position: _position, isWhite:tgt.isWhite){
            _possibleMoves.append(_position)
          }
        }
        if row - 1 >= Board.MIN_ROW_NUM && col - 1 >= Board.MIN_COL_NUM {
          let _position = Position(row: row - 1, column: col - 1)
          if foeExistsOnPosition(position: _position, isWhite:tgt.isWhite){
            _possibleMoves.append(_position)
          }
        }
      }
      possibleMoves = _possibleMoves
    default:
      break
    }
    
    return possibleMoves
  }
  
  func printAllPossibleMoves() {
    for (k, v) in board.findPossibleMoves() {
      print(k.getSquareString(), board.playBoard[k.row][k.column]?.symbol ?? "@", terminator: ": ")
      v.map({ print(ColString.convertColNumToColString(colNum: $0.column)! + $0.convertRowNumToRowString(rowNum: $0.column), terminator: " ") })
      print()
    }
  }
  
  /// move a piece
  func move(from:Position, to:Position) {
    let (from_row, from_col) = (from.row, from.column)
    let (to_row, to_col) = (to.row, to.column)
    self.playBoard[to_row][to_col] = self.playBoard[from_row][from_col]
    self.playBoard[from_row][from_col] = nil
  }
  
  func switchPlayer() {
    self.player = self.player == .white ? .black : .white
  }
  
  func judgeGameState() -> GameState {
    
    var foeKing: Piece? = nil
    for currentRow in self.playBoard {
      for currentPiece in currentRow {
        guard type(of: currentPiece) == King.Type.self else { continue }
        guard currentPiece?.isWhite == true && self.player == .white else { continue }
        foeKing = currentPiece!
      }
    }
    if foeKing != nil {
      let foeKingPossibleMoves = findPossibleMoves(tgt: foeKing!)
    }
    
    return .ongoing
  }
  
  // ----------------------------------------
  // Private Method
  // ----------------------------------------
  
  ///  return true if a piece exists on specified position
  private func pieceExistsOnPosition(position:Position) -> Bool {
    var pieceExists = false
    let _piece = playBoard[position.row][position.column]
    
    if _piece != nil {
      pieceExists = true
    }
    
    return pieceExists
  }
  
  ///  return true if a piece on our side  exists on specified position
  private func friendExistsOnPosition(position:Position, isWhite:Bool? = nil ) -> Bool {
    var _isWhite = false
    if isWhite == nil {
      _isWhite = player == .white
    } else {
      _isWhite = isWhite!
    }
    
    var friendExists = false
    let _piece = playBoard[position.row][position.column]
    
    if !pieceExistsOnPosition(position: position) {
      return false
    }
    let piece = _piece!
    if piece.isWhite && _isWhite || !piece.isWhite && !_isWhite {
      friendExists = true
    }
    
    return friendExists
  }
  
  ///  return true if a piece on opponent's side  exists on specified position
  private func foeExistsOnPosition(position:Position, isWhite:Bool? = nil) -> Bool {
    var _isWhite = false
    if isWhite == nil {
      _isWhite = player == .white
    } else {
      _isWhite = isWhite!
    }
    
    var foeExists = false
    let _piece = playBoard[position.row][position.column]
    
    if !pieceExistsOnPosition(position: position) {
      return false
    }
    let piece = _piece!
    if piece.isWhite && _isWhite || !piece.isWhite && !_isWhite {
      foeExists = true
    }
    
    return foeExists
  }
}

enum Player {
  case black, white
}

enum GameState: String {
    case ongoing, check, checkmate, stalemate, draw
}
