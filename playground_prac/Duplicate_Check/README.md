# Duplicate Check

## what does it do
 given an array, it will check for duplicates and will print out the duplicate elements 
 
 ## detailed walkthrough 
 given an array, `someFunc()` will iterate through it, making key-value pair for each element of the array.
  It will then go through the array again, to append elements on the corrosponding key entry. Since values are gonna be arrays, it cannot be done while constructing the key. `updateValue` method overwrites the existing value instead of append onto it
  finally it will iterate through the key-value pair, checking if any of values are more than 2 elems. and if so, it will print how many times that element has been repeated. 
  
## Runtime
O(n)
