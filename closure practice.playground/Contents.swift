import UIKit
func calc (n1 : Int, n2: Int, operation: (Int,Int)->Int) -> Int {  // this takes in function as a parameter, operation is the function parameter, and operation is a function that takes in 2 Ints and returns 1 Int
    return operation (n1,n2)
}


// just regular add function
func add (n1: Int, n2:Int) -> Int{
    return n1 + n2
}


// just simple multiply function
func mult (n1:Int,n2:Int)->Int {
    return n1*n2
}

print (calc(n1: 2, n2: 3, operation: add))
print (calc(n1: 2,n2: 3,operation: mult))


// this can be tranlated into this
print (calc(n1:2, n2: 3,operation: {(n1, n2)-> Int in
return n1*n2  // compiler will know what data type these will be
}))

// one step more
print (calc(n1:2, n2: 3,operation: {(n1, n2) in
return n1*n2  // now compiler will know what the return type of the closure will be too
}))

// one one more type, removing 'return' statement
print (calc(n1:2, n2: 3,operation: {(n1, n2) in  n1*n2  // now compiler will know what the return type of the closure will be too
}))

// one one more type, removing 'return' statement
print (calc(n1:2, n2: 3, operation: {$0 * $1})) // $0 stands for 'first input param', $1 stands for 'second input param' and so fourth

// one one more type, removing 'return' statement
print (calc(n1:2, n2: 3) {$0 * $1}) // trailing closure. ok this is hella simple but readability is not that good. choose your poison tho

// ---------------------------------------------------------------------------------------------------------------------------------------------
// more practical example

let arr = [6,2,3,9,4,1]

func addOne(n1: Int) -> Int {  // this adds 1. super complicated.
    return n1+1
}

// .map() takes a function as an input parameter and applies that function to every element of the array
arr.map(addOne)  // this will add 1 onto every element of array

// same order as above notations
arr.map( {(n1) in
    return n1 + 1}
)

arr.map( {(n1) in
    n1 + 1}
)

arr.map( {$0 + 1} )
