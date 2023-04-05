//
//  Piece.swift
//  Chess
//
//  Created by H.Namikawa on 2023/03/24.
//

import Foundation

class Piece: CustomStringConvertible, Equatable, Hashable{
  let SYMBOL_DICT: [Role: (Character, Character)] = [.pawn:   ("♙", "♟"),
                                                     .knight: ("♘", "♞"),
                                                     .rook:   ("♖", "♜"),
                                                     .bishop: ("♗", "♝"),
                                                     .queen:  ("♕", "♛"),
                                                     .king:   ("♔", "♚")]
  fileprivate var value: Int
  private(set) var isWhite: Bool
  var symbol: Character = "#"
  var role:Role = .noRole
  var position:Position = Position(row: 1, column: 1)
  
  var description: String{
    return "\(type(of: self))(value='\(value)')"
  }
  
  init(isWhite: Bool, position:Position? = nil) {
    self.value = 0
    self.isWhite = isWhite
    if position != nil {
      self.position = position!
    }
  }
  
  
  // Equatable
  static func ==(lhs:Piece, rhs:Piece) -> Bool{
    return lhs.value == rhs.value && lhs.isWhite == rhs.isWhite
  }
  
  // todo you need to modify
  // Hashable
  func hash(into hasher: inout Hasher) {
      hasher.combine(value)
  }

  
  // getter and setter for value
  func getValue() -> Int {
    return value
  }
  
  func setValue(value:Int){
    self.value = value
  }
  
  func move() {
    print("")
  }
  
  func assignSymbol(_ role: Role) -> Character {
    return isWhite ? SYMBOL_DICT[role]!.0 : SYMBOL_DICT[role]!.1
  }
  
  func getPossibleMoves() -> [Position] {
    fatalError("you need to implement this mothod in sub class.")
  }
}

class Pawn: Piece {
  
  private var promoted = false
  private var newPiece:Piece?
  
  init(isWhite: Bool, position:Position? = nil, promoted: Bool = false, newPiece:Piece? = nil) {
    super.init(isWhite: isWhite, position: position)
    self.value = 1
    self.role = .pawn
    self.promoted = promoted
    self.newPiece = newPiece
    self.symbol = assignSymbol(self.role)
  }
  
  // Equatable
  static func ==(lhs:Pawn, rhs:Pawn) -> Bool{
    if lhs.promoted != rhs.promoted {
      return false
    }
    
    var result = false
    if lhs.promoted {
      guard let lhsNewPiece = lhs.newPiece, let rhsNewPiece = rhs.newPiece else {
        return false
      }
      
      result =
        lhsNewPiece.value == rhsNewPiece.value && lhsNewPiece.isWhite == rhsNewPiece.isWhite
    } else {
      result = lhs.value == rhs.value && lhs.isWhite == rhs.isWhite
    }
    return result
  }
  
  override func getPossibleMoves() -> [Position] {
    var possibleMoves:[Position] = []
    let FIRST_ROW_WHITE = 1
    let FIRST_ROW_BLACK = 6
    
    if isWhite {
      if position.row == FIRST_ROW_WHITE {
        possibleMoves.append(Position(row: position.row + 1, column: position.column))
        possibleMoves.append(Position(row: position.row + 2, column: position.column))
      }
      possibleMoves.append(Position(row: position.row + 1, column: position.column))
    } else {
      if position.row == FIRST_ROW_BLACK {
        possibleMoves.append(Position(row: position.row + 1, column: position.column))
        possibleMoves.append(Position(row: position.row + 2, column: position.column))
      }
      possibleMoves.append(Position(row: position.row + 1, column: position.column))
    }
    
    return possibleMoves
  }
  
  override func move() {
    print("Forward 1")
  }
  
  func promote(_ newPiece:Piece) {
    self.newPiece = newPiece
    self.promoted = true
  }
  
//  func assignSymbol() -> Character {
//    return isWhite ? SYMBOL_DICT[role]!.0 : SYMBOL_DICT[role]!.1
//  }
}

class Knight: Piece {
  override init(isWhite: Bool, position:Position? = nil) {
    super.init(isWhite: isWhite, position: position)
    self.role = .knight
    self.value = 2
    self.symbol = assignSymbol(self.role)
  }
  
  override func getPossibleMoves() -> [Position] {
    var possibleMoves:[Position] = []
    
    // right uppper
    if position.row + 2 <= Board.MAX_ROW_NUM && position.column + 1 <= Board.MAX_COL_NUM {
      possibleMoves.append(Position(row: position.row + 2, column: position.column + 1))
    }
    // left upper
    if position.row + 2 <= Board.MAX_ROW_NUM && position.column - 1 >= Board.MIN_COL_NUM {
      possibleMoves.append(Position(row: position.row + 2, column: position.column - 1))
    }
    // right upper
    if position.row + 1 <= Board.MAX_ROW_NUM && position.column + 2 <= Board.MAX_COL_NUM {
      possibleMoves.append(Position(row: position.row + 1, column: position.column + 2))
    }
    // left uuper
    if position.row + 1 <= Board.MAX_ROW_NUM && position.column - 2 >= Board.MIN_COL_NUM {
      possibleMoves.append(Position(row: position.row + 1, column: position.column - 2))
    }
    // right lower
    if position.row - 2 >= Board.MIN_ROW_NUM && position.column + 1 <= Board.MAX_COL_NUM {
      possibleMoves.append(Position(row: position.row - 2, column: position.column + 1))
    }
    // left lower
    if position.row - 2 >= Board.MIN_ROW_NUM && position.column - 1 >= Board.MIN_COL_NUM {
      possibleMoves.append(Position(row: position.row - 2, column: position.column - 1))
    }
    // right lower
    if position.row - 1 >= Board.MIN_ROW_NUM && position.column + 2 <= Board.MAX_COL_NUM {
      possibleMoves.append(Position(row: position.row - 1, column: position.column + 2))
    }
    // left lower
    if position.row - 1 >= Board.MIN_ROW_NUM && position.column - 2 >= Board.MIN_COL_NUM {
      possibleMoves.append(Position(row: position.row - 1, column: position.column - 2))
    }
    
    return possibleMoves
  }
  
  override func move() {
    print("Like an L")
  }
}

class Bishop: Piece {
  
  override init(isWhite: Bool, position:Position? = nil) {
    super.init(isWhite: isWhite, position: position)
    self.role = .bishop
    self.value = 3
    self.symbol = assignSymbol(self.role)
  }
  
  override func getPossibleMoves() -> [Position] {
    var possibleMoves:[Position] = []
    let row = position.row
    let col = position.column
    
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
        possibleMoves.append(Position(row: rowNum, column: rightColNum))
      }
      if leftColNum >= Board.MIN_COL_NUM {
        possibleMoves.append(Position(row: rowNum, column: leftColNum))
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
        possibleMoves.append(Position(row: rowNum, column: rightColNum))
      }
      if leftColNum >= Board.MIN_COL_NUM {
        possibleMoves.append(Position(row: rowNum, column: leftColNum))
      }
      rowNum -= 1
    }
    
    return possibleMoves
  }
  
  override func move() {
    print("Diagonally")
  }
}

class Rook: Piece {
  
  override init(isWhite: Bool, position:Position? = nil) {
    super.init(isWhite: isWhite, position:position)
    self.role = .rook
    self.value = 5
    self.symbol = assignSymbol(self.role)
  }
  
  override func getPossibleMoves() -> [Position] {
    var possibleMoves:[Position] = []
    let row = position.row
    let col = position.column
    
    // verticle line
    for rowNum in Board.MIN_ROW_NUM...Board.MAX_ROW_NUM {
      if rowNum == row {
        continue
      }
      possibleMoves.append(Position(row: rowNum, column: col))
    }
    
    // horizontal line
    for colNum in Board.MIN_COL_NUM...Board.MAX_COL_NUM {
      if colNum == col {
        continue
      }
      possibleMoves.append(Position(row: row, column: colNum))
    }
    
    return possibleMoves
  }
  
  override func move() {
    print("Horizontally or vertically")
  }
}

class Queen: Piece {
  
  override init(isWhite: Bool, position:Position? = nil) {
    super.init(isWhite: isWhite, position: position)
    self.role = .queen
    self.value = 9
    self.symbol = assignSymbol(self.role)
  }
  
  override func getPossibleMoves() -> [Position] {
    var possibleMoves:[Position] = []
    let row = position.row
    let col = position.column
    
    // verticle line
    for rowNum in Board.MIN_ROW_NUM...Board.MAX_ROW_NUM {
      if rowNum == row {
        continue
      }
      possibleMoves.append(Position(row: rowNum, column: col))
    }
//    for rowNum in row...Board.MAX_ROW_NUM {
//      if rowNum == row {
//        continue
//      }
//      possibleMoves.append(Position(row: rowNum, column: position.column))
//    }
//    for rowNum in Board.MIN_ROW_NUM...row {
//      if rowNum == row {
//        continue
//      }
//      possibleMoves.append(Position(row: rowNum, column: col))
//    }
    
    // horizontal line
    for colNum in Board.MIN_COL_NUM...Board.MAX_COL_NUM {
      if colNum == col {
        continue
      }
      possibleMoves.append(Position(row: row, column: colNum))
    }
//    for colNum in col...Board.MAX_COL_NUM {
//      if colNum == col {
//        continue
//      }
//      possibleMoves.append(Position(row: row, column: colNum))
//    }
//    for colNum in Board.MIN_COL_NUM...col {
//      if colNum == col {
//        continue
//      }
//      possibleMoves.append(Position(row: row, column: colNum))
//    }
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
        possibleMoves.append(Position(row: rowNum, column: rightColNum))
      }
      if leftColNum >= Board.MIN_COL_NUM {
        possibleMoves.append(Position(row: rowNum, column: leftColNum))
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
        possibleMoves.append(Position(row: rowNum, column: rightColNum))
      }
      if leftColNum >= Board.MIN_COL_NUM {
        possibleMoves.append(Position(row: rowNum, column: leftColNum))
      }
      rowNum -= 1
    }
    
    return possibleMoves
  }
  
  override func move() {
    print("Like bishop and rook")
  }
}

class King: Piece {
  
  override init(isWhite: Bool, position:Position? = nil) {
    super.init(isWhite: isWhite, position: position)
    self.role = .king
    self.value = 1000
    self.symbol = assignSymbol(self.role)
  }
  
  override func getPossibleMoves() -> [Position] {
    var possibleMoves:[Position] = []
    
    // forward(from white side)
    if position.row + 1 <= Board.MAX_ROW_NUM {
      possibleMoves.append(Position(row: position.row + 1, column: position.column))
    }
    // backward(from white side)
    if position.row - 1 >= Board.MIN_ROW_NUM {
      possibleMoves.append(Position(row: position.row - 1, column: position.column))
    }
    // rigth
    if position.column + 1 <= Board.MAX_COL_NUM {
      possibleMoves.append(Position(row: position.row, column: position.column + 1))
    }
    // left
    if position.column - 1 >= Board.MIN_COL_NUM {
      possibleMoves.append(Position(row: position.row, column: position.column - 1))
    }
    // upper right(from white side)
    if position.row + 1 <= Board.MAX_ROW_NUM && position.column + 1 <= Board.MAX_COL_NUM {
      possibleMoves.append(Position(row: position.row + 1, column: position.column + 1))
    }
    // upper left(from white side)
    if position.row + 1 <= Board.MAX_ROW_NUM && position.column - 1 >= Board.MIN_COL_NUM {
      possibleMoves.append(Position(row: position.row + 1, column: position.column - 1))
    }
    // lower right(from white side)
    if position.row - 1 >= Board.MIN_ROW_NUM && position.column + 1 <= Board.MAX_COL_NUM {
      possibleMoves.append(Position(row: position.row - 1, column: position.column + 1))
    }
    // lower left(from white side)
    if position.row - 1 >= Board.MIN_ROW_NUM && position.column - 1 >= Board.MIN_COL_NUM {
      possibleMoves.append(Position(row: position.row - 1, column: position.column - 1))
    }
    
    return possibleMoves
  }
  
  override func move() {
    print("One square")
  }
}

enum Role {
  case pawn, rook, knight, bishop, queen, king, noRole
    
//  func initialize(color: PieceColor, position: Position) -> Piece {
//    switch self {
//    case .pawn:
//      return Pawn(color: color, position: position)
//    case .rook:
//      return Rook(color: color, position: position)
//    case .knight:
//      return Knight(color: color, position: position)
//    case .bishop:
//      return Bishop(color: color, position: position)
//    case .queen:
//      return Queen(color: color, position: position)
//    case .king:
//      return King(color: color, position: position)
//    }
//  }
}
