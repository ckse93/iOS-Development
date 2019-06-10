//
//  sorting.cpp
//  
//
//  Created by Chan Jung on 6/9/19.
//

#include <iostream>
#include <vector>
#include "sorting.hpp"


void displayVector (std::vector<int> arr) {
    std::cout << "the array is : ";
    int length = arr.size();
    for (int i =0; i < length; i++) {
        std::cout << arr[i] << ", ";
    }
    std::cout << "\n";
}

void bubbleSort (std::vector<int>& vec, bool reverse) {
    int len = vec.size();
    for (int i = 0; i < len; i++) {
        for (int j = 0; j < len-1; j++) {
            if (vec[j] > vec[j+1]) {
                int swap = vec[j];
                vec[j] = vec[j+1];
                vec[j+1] = swap;
            }
        }
    }
    if (reverse == true) {
        for (int i = 0; i < (int)len/2; i++){
            int swap = vec[i];
            vec[i] = vec[len-i-1];
            vec[len-i-1] = swap;
        }
    }
}


int main (){
    std::vector<int> vec = {1,4,3,2,5,7,5,3,1,2,8,9,6,5,32,5,645,2,2,234,0,867,1};
    displayVector(vec);
    /*********************************BUBBLESORT*******************************************/
    bubbleSort(vec, false);
    displayVector(vec);
    bubbleSort(vec,true);
    displayVector(vec);
    
    return 0;
}
