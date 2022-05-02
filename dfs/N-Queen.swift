import Foundation

let n = 4
var result = 0

for row in 0..<n {
    for column in 0..<n {
        
        let board = ChessBoard(width: n)
        let point = QueenPoint(in: row, at: column)
        
        board.placeQueen(at: point)
        checkQueen(at: point, board: board)
    }
}

func checkQueen(at point: QueenPoint, board: ChessBoard) {
    
    if point.row == n-1 && point.column == n-1 {
        result += (board.queenCount == n ? 1 : 0)
        return
    }
    
    if board.queenCount > n {
        return
    }
    
    board.setQueen()
    
    if board[point] {
        
        board.placeQueen(at: point)
        
        let newBoard = ChessBoard(width: n)
        newBoard.queenPosition = board.queenPosition
        checkQueen(at: point.getNextPoint(), board: newBoard)
    }
    
    checkQueen(at: point.getNextPoint(), board: board)
}

enum DiagonalDirection {
    case upperLeft
    case upperRight
    case downLeft
    case downRight
    
    func moveRow() -> Int {
        if self == .upperLeft || self == .upperRight {
            return -1
        }
        return 1
    }
    
    func moveColumn() -> Int {
        if self == .upperLeft || self == .downLeft {
            return -1
        }
        return 1
    }
}

struct QueenPoint: Hashable {
    let row: Int
    let column: Int
    
    init(in row: Int, at column: Int) {
        self.row = row
        self.column = column
    }
    
    func getNextPoint() -> QueenPoint {
        return QueenPoint(
            in: row + (column+1 == n ? 1 : 0),
            at: (column+1 == n ? 0 : column+1)
        )
    }
    
    func moveDiagonal(_ direction: DiagonalDirection) -> QueenPoint {
        return QueenPoint(
            in: row + direction.moveRow(),
            at: column + direction.moveColumn()
        )
    }
}

class ChessBoard {
    private var width: Int
    var queenPosition = Set<QueenPoint>()
    var chessBoard: [[Bool]]
    var queenCount: Int {
        queenPosition.count
    }
    
    subscript(point: QueenPoint) -> Bool {
        get {
            return chessBoard[point.row][point.column]
        }
        set(newValue) {
            chessBoard[point.row][point.column] = newValue
        }
    }
    
    subscript(row: Int) -> [Bool] {
        get {
            return chessBoard[row]
        }
        set(newValue) {
            chessBoard[row] = newValue
        }
    }
    
    init(width: Int) {
        self.width = width
        chessBoard = Array(repeating: [Bool](repeating: true, count: width), count: width)
    }
    
    func setQueen() {
        chessBoard = Array(repeating: [Bool](repeating: true, count: width), count: width)
        
        for point in queenPosition {
            chessBoard[point.row] = chessBoard[point.row].map { _ in return false }
            
            for innerRow in 0..<n {
                chessBoard[innerRow][point.column] = false
            }
            
            diagonalCheck(at: point, direction: .upperLeft)
            diagonalCheck(at: point, direction: .upperRight)
            diagonalCheck(at: point, direction: .downLeft)
            diagonalCheck(at: point, direction: .downRight)
            
            chessBoard[point.row][point.column] = true
        }
    }
    
    func placeQueen(at point: QueenPoint) {
        queenPosition.insert(point)
    }
    
    func removeQueen(at point: QueenPoint) {
        queenPosition.remove(point)
    }
    
    private func diagonalCheck(at point: QueenPoint, direction: DiagonalDirection) {
        if point.row < 0 || point.column < 0 || point.row == width || point.column == width {
            return
        }
        
        chessBoard[point.row][point.column] = false
        
        diagonalCheck(at: point.moveDiagonal(direction), direction: direction)
    }
}

print(result)
