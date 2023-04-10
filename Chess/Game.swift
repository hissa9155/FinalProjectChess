//
//  Game.swift
//  Chess
//
//  Created by H.Namikawa on 2023/04/04.
//

import Foundation

class Game {
  var board = Board(gameState: .ongoing, player: .white)
  // game starts
  func start() {
    var counter = 0
    //    board = Board(gameState: .ongoing, player: .black)
    var currentPlayer = board.player
    while true {
      
      currentPlayer = board.player
      self.board.displayBoard()
      
      print("[type 'help' for help] \(currentPlayer): ", terminator: "")
      //      board.displayBoard()
      let input = readLine()
      if input == "help" {
        print(showHelp())
        continue
      } else if input == "board" {
        board.displayBoard()
        continue
      } else if input == "resign" {
        board.switchPlayer()
        print("Game over - \(currentPlayer) won by resignation")
        break
      } else if validateMove(input!) {
        move(input!)
      } else if validateShowPossibleMoves(input!) {
        board.printPossiblePlayerMoves()
        continue
      }
      counter += 1
      print(self.board.judgeGameState())
      if board.judgeGameState() == .check {
        print("Check!")
      }
      self.board.switchPlayer()
    }
  }
  
  
  /// deal with "help" command
  func showHelp() {
    print("Commands:")
    print("help - show this help message")
    print("board - display the board")
    print("resign - resign the game")
    print("moves - show all possible moves for current player")
    print("<square> - show all possible moves for piece on the square (e.g., 'e2')")
    print("<move> - make the move (e.g., 'e2 e4')")
  }
  
  /// deal with "board" command
  private func showBoard() {
    // please use "displayBoard" in Board class
  }
  
  ///  deal with "resign" command
  private func resign() {
    
  }
  
  /// deal with "moves" command
  private func showPossibleMoves() {
    // please use "findPossibleMove" in Board class
  }
  
  /// deal with square command
  private func showPossibleMoves(position:Position) {
    
  }
  
  private func validateMove(_ input: String) -> Bool {
    guard input.count == 4 else { return false }
    if let rowIndex1 = Int(input[input.index(input.startIndex, offsetBy: 1)..<input.index(input.startIndex, offsetBy: 2)]), let rowIndex2 = Int(input[input.index(input.startIndex, offsetBy: 3)..<input.index(input.startIndex, offsetBy: 4)]) {
      return true
    }
    return false
  }
  
  private func validateShowPossibleMoves(_ input: String) -> Bool {
    guard input.count == 2 else { return false }
    if let rowIndex1 = Int(input[input.index(input.startIndex, offsetBy: 1)..<input.index(input.startIndex, offsetBy: 2)]) {
      return true
    } else {
      return false
    }
  }
  
  /// deal with UCI command to move
  private func move(_ input: String) {
    let pos1str = String(input[input.startIndex..<input.index(input.startIndex, offsetBy: 2)])
    let pos2str = String(input.suffix(2))
//    print(pos1str, pos2str)
    let pos1 = Position(square: pos1str)
    let pos2 = Position(square: pos2str)
//    print(pos1, pos2)
    self.board.move(from: pos1, to: pos2)
  }
  
}
