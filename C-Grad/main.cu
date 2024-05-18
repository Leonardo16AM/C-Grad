#include "value.h"
#include <iostream>
#include <cuda_runtime.h>
using namespace std;

int main() {
    
    value a(10.0);
    value b(20.0);
    value d=a+b;

    value c=30;
    value e=d*c;

    e.backpropagate();

    e.print();



    return 0;
}
