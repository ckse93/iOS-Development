import Foundation

func sorter (arr : [Int]) -> [Int] {
    var zero : [Int] = []
    var one : [Int] = []
    var two : [Int] = []

    for i in arr {
        if (i == 0) {
            zero.append(i)
        } else if (i == 1) {
            one.append(i)
        } else if (i == 2) {
            two.append(i)
        }
    }
    return zero+one+two
}

let input = [0,1,2,2,0,0,0,1,2,1]
print (input)
print (sorter(arr : input))
