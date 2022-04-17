import Foundation

let n = 4
var chessBoard = Array(repeating: Array(repeating: false, count: n), count: n)
var resultSet = [(row:Int, column:Int)]()
var result = 0

for row in 0..<chessBoard.endIndex {
    for column in 0..<chessBoard.endIndex {
        
        chessBoard[row][column] = true
        resultSet.append((row: row, column: column))
        
        for testRow in 0..<chessBoard.endIndex {
            for testColumn in 0..<chessBoard.endIndex {
                if testRow == row && testColumn == column {
                    continue
                } else if resultSet.contains(where: {$0.row == testRow}) {
                    chessBoard[testRow][testColumn] = false
                } else if resultSet.contains(where: {$0.column == testColumn}) {
                    chessBoard[testRow][testColumn] = false
                } else if testRow == testColumn {
                    chessBoard[testRow][testColumn] = false
                } else {
                    chessBoard[testRow][testColumn] = true
                    resultSet.append((row: testRow, column: testColumn))
                }
            }
        }
        
        if n == chessBoard.reduce(0, { $0 + $1.filter({isQueen in isQueen == true}).count}) {
            result += 1
        }
        
        chessBoard = Array(repeating: Array(repeating: false, count: n), count: n)
        resultSet.removeAll()
    }
}

print(result)
