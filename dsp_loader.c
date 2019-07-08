//
//  dsp_loader.c
//  
//
//  Created by Chan Jung on 7/2/19.
//

#include "dsp_loader.h"
#include <string.h>
#include <stdio.h>
#include <stdbool.h>

// this adapter program is designed to parse and load any .dsp file and

/* program flow
 1. check if the input file has the correct extension
 2. read the file, parsing it, and store the relavant data into a struct
 3. read the struct to reformat, and display it out
*/
bool isCorrectExtension (char* str) {
    char ext[] = ".dsp";
    char * checker = strstr (str, ext);  // storing the instance of str and ".dsp" into checker
    printf ("input is = %s\n", str);
    printf ("ext is = %s\n", ext);
    printf ("checker is = %s\n", checker);
    if (strcmp(checker, ext) == 0) {  // when the extension is .dsp
        printf ("correct extension\n");
        return true;
    }
    else {
        printf ("wrong extension\n");
        return false;
    }
}

int main (int argc, char* argv[]) {
    
    if(isCorrectExtension(argv[1])) {
        FILE *input_file = fopen(argv[1], 'r');  // reading a file from an argument line, in "read mode"
    } else {
        return -1;
    }
    return 0;
}
