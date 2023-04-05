//
//  Position.swift
//  Chess
//
//  Created by H.Namikawa on 2023/04/04.
//

import Foundation

struct Position: Equatable, Hashable {
  let row:Int
  let column:Int
  
  init(row: Int, column: Int) {
    self.row = row
    self.column = column
  }
  
  /// init from square like "b1", "a2"
  init(square:String) {
    self.row = convertSquare2RowCol(cell: square)[1]
    self.column = convertSquare2RowCol(cell: square)[0]
  }
  
  /// get row string like "1", "2"
  func getRowString() -> String {
    return String(8-self.row)
  }
  
  /// get row string like "a", "b"
  func getColString() -> String {
    return ColString.convertColNumToColString(colNum: self.column)!
  }
  
  /// get squre string like "b1", "a2"
  func getSquareString() -> String {
    return getColString() + getRowString()
  }
  
  func convertRowNumToRowString(rowNum: Int) -> String {
    return String(8-rowNum)
  }

  /// if it is necesarry, you need to implement
  static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row
  }
}

func convertRowStringToRowNum(rowString: String) -> Int {
  return Int(rowString)!
}

/// if it is necesarry, you need to implement
/// you shold convert from "b2" -> [2, 2]
func convertSquare2RowCol(cell: String) -> [Int] {
  let col = ColString.convertColStringToColNum(colStr: String(cell.prefix(1)))!
  let row = convertRowStringToRowNum(rowString: String(cell.suffix(1)))
  return [col, row]
}

// if you need to use
enum ColString: String {
  case A = "a", B = "b", C = "c", D = "d", E = "e", F = "f", G = "g", H = "h"
  
  static func convertColNumToColString(colNum:Int) -> String? {
    switch colNum {
    case 0: return A.rawValue
    case 1: return B.rawValue
    case 2: return C.rawValue
    case 3: return D.rawValue
    case 4: return E.rawValue
    case 5: return F.rawValue
    case 6: return G.rawValue
    case 7: return H.rawValue
    default: return nil
    }
  }
  
  static func convertColStringToColNum(colStr: String) -> Int? {
    switch colStr {
    case A.rawValue: return 0
    case B.rawValue: return 1
    case C.rawValue: return 2
    case D.rawValue: return 3
    case E.rawValue: return 4
    case F.rawValue: return 5
    case G.rawValue: return 6
    case H.rawValue: return 7
    default: return nil
    }
  }
}
