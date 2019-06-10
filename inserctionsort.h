//
//  inserctionsort.h
//  
//
//  Created by Chan Jung on 6/10/19.
//
#include <iostream>

#ifndef inserctionsort_h
#define inserctionsort_h

void inserctionSort(std::vector<int> &vec) {
    std::cout << "inserction sort called\n";
    for (int i = 1; i < vec.size(); i++) {
        int temp = vec[i];
        int length = vec.size();
        int j = i-1;
        while (temp < vec[j] && (j>=0)) {
            vec[j+1] = vec[j];
            j++;
        }
        vec[j+1] = temp;
        std::cout << "iteration : " << i<<std::endl;
    }
}


#endif /* inserctionsort_h */
