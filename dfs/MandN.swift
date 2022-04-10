import Foundation

typealias ResultAttribute = Array<Int>

let line = readLine()!
let lineArr = line.components(separatedBy: " ")
let n = Int(lineArr[0])!
let m = Int(lineArr[1])!

// 1 <= m <= n <= 8

var resultAttribute = ResultAttribute.init(repeating: 1, count: m)
var result = Array<ResultAttribute>()
var dpSet = Set<ResultAttribute>()

if n == 1 {
    print(1)
} else if m == 1 {
    for i in 1...n {
        print(i)
    }
} else {
    dfs(at: 0, resultAttribute: &resultAttribute)
}

func dfs(at column: Int, resultAttribute: inout ResultAttribute) {
    for num in 1...n {
        
        resultAttribute[column] = num
        
        let partialResultAttribute = Array(resultAttribute[0...column])
        
        guard dpSet.contains(partialResultAttribute) == false, dpSet.contains(resultAttribute) == false else { break }
        
        if resultAttribute.isUnique(), dpSet.contains(resultAttribute) == false {
            dpSet.insert(resultAttribute)
            result.append(resultAttribute)
        }
        
        if column < resultAttribute.count-1, dpSet.contains(partialResultAttribute) == false {
            print(resultAttribute, partialResultAttribute, column)
            dpSet.insert(partialResultAttribute)
            dfs(at: column+1, resultAttribute: &resultAttribute)
        }
    }
    resultAttribute[column] = 1
}

result.forEach { sentences in
    var word = String(sentences.first!)
    
    if sentences.count >= 2 {
        for i in 1...sentences.count-1 {
            word += " \(sentences[i])"
        }
    }
    
    print(word)
}

extension ResultAttribute: Comparable {
    public static func < (lhs: Array<Element>, rhs: Array<Element>) -> Bool {
        guard lhs.count == rhs.count else { return false }
        
        let lh = lhs.sorted()
        let rh = rhs.sorted()
        
        for i in 0..<lh.count {
            if lh[i] == rh[i] {
                continue
            } else if lh[i] < rh[i] {
                return true
            } else if lh[i] > rh[i] {
                return false
            }
        }
        
        return false
    }
    
    func isUnique() -> Bool {
        Set.init(self).count == self.count
    }
}
