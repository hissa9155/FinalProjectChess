//
//  Position.swift
//  Chess
//
//  Created by H.Namikawa on 2023/04/04.
//

import Foundation

struct Position: Equatable, Hashable{
  let row:Int
  let column:Int
  
  init(row: Int, column: Int) {
    self.row = row
    self.column = column
  }
  
  /// init from square like "b1", "a2"
  init?(square:String){
    // need to modify
    self.row = 1
    self.column = 1
  }
  
  /// get row string like "a", "b"
  func getRowString() -> String {
    return ""
  }
  
  /// get squre string like "b1", "a2"
  func getSquareString() -> String {
    return ""
  }
  
  /// if it is necesarry, you need to implement
  /// you shold convert from "b2" -> [2, 2]
  static func convertSquare2RowCol() -> [Int] {
    return [1]
  }
  
  /// if it is necesarry, you need to implement
  static func == (lhs: Self, rhs: Self) -> Bool {
    return true
  }
}
