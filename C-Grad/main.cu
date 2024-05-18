#include "value.h"
#include <iostream>
#include <cuda_runtime.h>


int main() {
    // Crear un objeto value en el host
    value a(10.0);
    value b(20.0);

    value d=a+b;

    d.backpropagate();

    d.print();



    return 0;
}
