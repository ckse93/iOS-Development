import Foundation

let lst = [1,2,0,0] // this will translated as 1200
let lst2 = [1,2,3,4]
func addTwo (a : [Int], b : [Int]) -> [String]{
    var aStr = ""
    var bStr = ""
    var out : [String] = []
    for i in a {
        aStr = aStr + String(i)
    }
    for j in b {
        bStr = bStr + String(j)
    }
    let result : Int = Int(aStr)! + Int(bStr)!
    for char in String(result) {
        out.insert(String(char), at : out.count)
    }
    return out
}

print (addTwo(a : lst, b : lst2))
