//
//  Piece.swift
//  Chess
//
//  Created by H.Namikawa on 2023/03/24.
//

import Foundation

class Piece: CustomStringConvertible, Equatable, Hashable{
  fileprivate var value:Int
  fileprivate var isWhite:Bool
  
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
}

class Pawn: Piece {
  
  private var promoted = false
  private var newPiece:Piece?
  
  init(isWhite: Bool, promoted: Bool = false, newPiece:Piece? = nil) {
    super.init(isWhite: isWhite)
    self.value = 1
    self.promoted = promoted
    self.newPiece = newPiece
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
}

class Knight: Piece {
  override init(isWhite: Bool) {
    super.init(isWhite: isWhite)
    self.value = 2
  }
  
  override func move() {
    print("Like an L")
  }
}

class Bishop: Piece {
  override init(isWhite: Bool) {
    super.init(isWhite: isWhite)
    self.value = 3
  }
  
  override func move() {
    print("Diagonally")
  }
}
class Rook: Piece {
  override init(isWhite: Bool) {
    super.init(isWhite: isWhite)
    self.value = 5
  }
  
  override func move() {
    print("Horizontally or vertically")
  }
}
class Queen: Piece {
  override init(isWhite: Bool) {
    super.init(isWhite: isWhite)
    self.value = 9
  }
  
  override func move() {
    print("Like bishop and rook")
  }
}
class King: Piece {
  override init(isWhite: Bool) {
    super.init(isWhite: isWhite)
    self.value = 1000
  }
  
  override func move() {
    print("One square")
  }
}
