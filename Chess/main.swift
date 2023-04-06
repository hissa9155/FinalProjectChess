//
//  main.swift
//  Chess
//
//  Created by H.Namikawa on 2023/04/04.
//

import Foundation

//let game = Game()
//game.start()

var board = Board(gameState: .ongoing, player: .white)

board.displayBoard()


//var dict = board.findPossibleMoves()
//
//for elm in dict {
//  print("\(elm.key.getSquareString()) : \(elm.value)")
//}

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

let b1 = Bishop(isWhite: false, position: Position(square: "f8"))
//let r0 = Rook(isWhite: false, position: Position(square: "a8"))
let r1 = Rook(isWhite: false, position: Position(square: "h8"))
let q = Queen(isWhite: false, position: Position(square: "e5"))
//let g = King(isWhite: false, position: Position(square: "d8"))

//let b0 = Bishop(isWhite: false, position: Position(square: "e5"))
let g = King(isWhite: false, position: Position(square: "e5"))
print(g.position)
var result = board.findPossibleMoves(tgt:g)

for elm in result {
  print(elm.getSquareString())
}

