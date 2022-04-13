import Foundation

let read = readLine()!
let readComponents = read.components(separatedBy: " ")

let n = Int(readComponents[0])!
let m = Int(readComponents[1])!

var result = [String]()

var temp = ""

func dfs(_ value: inout String) {
    if value.count == m {
        result.append(value.reduce("") { partialResult, next in
            partialResult + (partialResult.count == 0 ? "" : " ") + String(next)
        })
        return
    }
    
    for num in 1...n {
        var temp = value + String(num)
        
        if Set(temp).count == temp.count {
            dfs(&temp)
        }
    }
}


for num in 1...n {
    var temp = String(num)
    dfs(&temp)
}

result.forEach { str in
    print(str)
}
