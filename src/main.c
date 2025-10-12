#include <stdio.h>
#include "calc.h"

int main(void) {
    int x = 7, y = 5;
    printf("add(%d, %d) = %d\n", x, y, add(x, y));
    printf("sub(%d, %d) = %d\n", x, y, sub(x, y));
    return 0;
}

