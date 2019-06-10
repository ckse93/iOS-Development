//
//  bubblesort.cpp
//  
//
//  Created by Chan Jung on 6/10/19.
//

#include <stdio.h>


void bubbleSort (std::vector<int>& vec, bool reverse) {
    std::cout << "bubble sort called\n";
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
