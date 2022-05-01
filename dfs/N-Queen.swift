import Foundation

let n = 3
var chessBoard: [[Bool]] { Array(repeating: [Bool](repeating: true, count: n), count: n) }
var result = 0

for row in 0..<n {
    for column in 0..<n {
        
        var board = chessBoard
        
        board[row] = board[row].map { _ in false }
        
        for innerRow in 0..<n {
            board[innerRow][column] = false
        }
        
        diagonalCheck(in: row-1, at: column-1, board: &board, direction: .upperLeft)
        diagonalCheck(in: row-1, at: column+1, board: &board, direction: .upperRight)
        diagonalCheck(in: row+1, at: column-1, board: &board, direction: .downLeft)
        diagonalCheck(in: row+1, at: column+1, board: &board, direction: .downRight)
        
        board[row][column] = true
        
        if column+1 == n {
            if row+1 == n {
                continue
            }
            checkQueen(in: row+1, at: 0, board: &board)
        } else {
            checkQueen(in: row, at: column+1, board: &board)
        }
    }
}

func checkQueen(in row: Int, at column: Int, board: inout [[Bool]]) {
    
    let queenCount = board.reduce(0, {$0 + $1.filter({$0 == true}).count})
    
    if queenCount == n {
        result += 1
        return
    } else if row == n-1 && column == n-1 {
        return
    } else if queenCount < n {
        return
    }
    
    if board[row][column] {
        
        board[row] = board[row].map { _ in return false }
        
        for innerRow in 0..<n {
            board[innerRow][column] = false
        }
        
        board[row][column] = true
        
        diagonalCheck(in: row-1, at: column-1, board: &board, direction: .upperLeft)
        diagonalCheck(in: row-1, at: column+1, board: &board, direction: .upperRight)
        diagonalCheck(in: row+1, at: column-1, board: &board, direction: .downLeft)
        diagonalCheck(in: row+1, at: column+1, board: &board, direction: .downRight)
    }
    
    if column+1 == n {
        checkQueen(in: row+1, at: 0, board: &board)
    } else {
        checkQueen(in: row, at: column+1, board: &board)
    }
}

func diagonalCheck(in row: Int, at column: Int, board: inout [[Bool]], direction: DiagonalDirection) {
    if row < 0 || column < 0 || row == n || column == n {
        return
    }
    
    board[row][column] = false
    
    diagonalCheck(
        in: row + direction.moveRow(),
        at: column + direction.moveColumn(),
        board: &board,
        direction: direction
    )
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

print(result)
