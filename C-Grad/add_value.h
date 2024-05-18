#include <iostream>
#include "value.h"
#include <string>


#ifndef ADD_VALUE_H
#define ADD_VALUE_H


 
class add_value : public value{
public:
    add_value(value* left, value* right) : value(left->data + right->data, left->name + "+" + right->name, left, right) {}

    void backward () override{
        std::cout<<"Using overided add"<<std::endl;
        left->grad += grad;
        right->grad += grad;
    }
};

#endif
