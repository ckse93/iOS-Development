import UIKit

func foo() {
    print("this 1")
    
    DispatchQueue.global().sync {
        print ("----------------------------")
        print("this 2")
        
        DispatchQueue.global().async {
            print ("this 3")
        }
        
        DispatchQueue.global().async {
            print ("this 4")
        }
        
        DispatchQueue.global().async {
            print ("this 5")
        }
        
        DispatchQueue.global().async {
            print ("this 6")
        }
        
        print ("this 7")
    }
    print ("----------------------------")
    print ("this 8")
}

print ("start the function")
foo()
print ("finish the function")
