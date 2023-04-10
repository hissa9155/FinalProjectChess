import Foundation

enum PieceType {
    case pawn, rook, knight, bishop, queen, king

    func initialize(color: PieceColor, position: Position) -> Piece {
        switch self {
        case .pawn:
            return Pawn(color: color, position: position)
        case .rook:
            return Rook(color: color, position: position)
        case .knight:
            return Knight(color: color, position: position)
        case .bishop:
            return Bishop(color: color, position: position)
        case .queen:
            return Queen(color: color, position: position)
        case .king:
            return King(color: color, position: position)
        }
    }
}

enum PieceColor: String {
    case white, black
}

enum GameState: String {
    case ongoing, check, checkmate, stalemate, draw
}
