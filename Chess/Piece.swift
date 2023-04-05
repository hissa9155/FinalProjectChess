//
//  Piece.swift
//  Chess
//
//  Created by H.Namikawa on 2023/03/24.
//

import Foundation

class Piece: CustomStringConvertible, Equatable, Hashable{
  let SYMBOL_DICT: [Role: (Character, Character)] = [.pawn:   ("♟", "♙"),
                                                     .knight: ("♞", "♘"),
                                                     .rook:   ("♜", "♖"),
                                                     .bishop: ("♝", "♗"),
                                                     .queen:  ("♛", "♕"),
                                                     .king:   ("♚", "♔")]
  fileprivate var value: Int
  fileprivate var isWhite: Bool
  var symbol: Character = "#"
  
  // positon????
  var position:Position = Position(row: 1, column: 1)
  
  var description: String{
    return "\(type(of: self))(value='\(value)')"
  }
  
  init(isWhite: Bool) {
    self.value = 0
    self.isWhite = isWhite
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
}

class Pawn: Piece {
  
  private var promoted = false
  private var newPiece:Piece?
  var role: Role = .pawn
  
  init(isWhite: Bool, promoted: Bool = false, newPiece:Piece? = nil) {
    super.init(isWhite: isWhite)
    self.value = 1
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
  var role: Role = .knight
  override init(isWhite: Bool) {
    super.init(isWhite: isWhite)
    self.value = 2
    self.symbol = assignSymbol(self.role)
  }
  
  override func move() {
    print("Like an L")
  }
}

class Bishop: Piece {
  var role: Role = .bishop
  
  override init(isWhite: Bool) {
    super.init(isWhite: isWhite)
    self.value = 3
    self.symbol = assignSymbol(self.role)
  }
  
  override func move() {
    print("Diagonally")
  }
}

class Rook: Piece {
  var role: Role = .rook
  
  override init(isWhite: Bool) {
    super.init(isWhite: isWhite)
    self.value = 5
    self.symbol = assignSymbol(self.role)
  }
  
  override func move() {
    print("Horizontally or vertically")
  }
}

class Queen: Piece {
  var role: Role = .queen
  override init(isWhite: Bool) {
    super.init(isWhite: isWhite)
    self.value = 9
    self.symbol = assignSymbol(self.role)
  }
  
  override func move() {
    print("Like bishop and rook")
  }
}

class King: Piece {
  var role: Role = .king
  override init(isWhite: Bool) {
    super.init(isWhite: isWhite)
    self.value = 1000
    self.symbol = assignSymbol(self.role)
  }
  
  override func move() {
    print("One square")
  }
}

enum Role {
  case pawn, rook, knight, bishop, queen, king
    
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
