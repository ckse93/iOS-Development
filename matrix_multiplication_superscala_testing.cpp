//
//  matrix_multiplication_superscala_testing.cpp
//  viewTesting
//
//  Created by Chan Jung on 5/14/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//
#include <iostream>
#include <string>
#include <ctime>
#include "matrix_multiplication_superscala_testing.hpp"

int main (int argc, char ** argv) {
    int matrix[100][100];  // making 100 by 100 matrix.
    int a = 0;
    for (int i = 0; i < 100 ; i++) {
        for (int j = 0; j< 100; j++){
            matrix[i][j] = a;
            a++;
            std::cout<<matrix[i][j]<<std::endl;
        }
    }
    
    
    
    return 0;
}
