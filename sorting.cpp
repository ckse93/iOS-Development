//
//  sorting.cpp
//  
//
//  Created by Chan Jung on 6/9/19.
//

#include <iostream>
#include <vector>
#include "sorting.hpp"
#include "inserctionsort.h"
#include "bubblesort.h"


void displayVector (std::vector<int> arr);

int main (){
    std::vector<int> vec = {1,4,3,2,5,7,5,3,1,2,8,9,6,5,32,5,645,2,2,234,0,867,1};
    displayVector(vec);
    /*********************************BUBBLESORT*******************************************/
    bubbleSort(vec, false);
    displayVector(vec);
    bubbleSort(vec,true);
    displayVector(vec);
    inserctionSort(vec);
    displayVector(vec);
    
    return 0;
}

void displayVector (std::vector<int> arr) {
    std::cout << "the array is : ";
    for (int i = 0 ; i < arr.size(); i++) {
        std::cout << arr[i] << ",";
    }
    std::cout << "\n";
}
