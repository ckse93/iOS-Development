import UIKit

func FibonacciSequence(ith : Int) -> Int {
    if (ith < 2) {
        return ith;
    } else {
        return FibonacciSequence(ith: ith-1) + FibonacciSequence(ith: ith-2)
    }
}

func FibonacciOptimized (ith : Int) -> Int {
    var a = 0
    var b = 1
    var c = 0
    if ith == 0 {
        return a
    } else {
        for _ in 2...ith {
            c = a+b
            a = b
            b = c
        }
    }
    return b
}

print(FibonacciSequence(ith: 8))
