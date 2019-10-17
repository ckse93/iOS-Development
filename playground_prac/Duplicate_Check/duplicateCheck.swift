import Cocoa
let arr = [1,1,2,3,1,2,4,6,5,3,2,1,2,3]

func duplicateCheck (arr : [Int]) -> Void{
    var dict : [String : [String]] = [:]
    for i in arr {  // Since values are gonna be lists. we need to init as key-emptyValue pair
        dict.updateValue([""], forKey: String(i))
    }
    for j in arr {
        dict[String(j)]?.append(String(j))
    }
    for (_,v) in dict {
        if (v.count > 2) {
            print("\(v[1])" + " is repeated " + "\(v.count-1)" + " times")
        }
    }
}
duplicateCheck(arr: arr)

