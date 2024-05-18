#include <iostream>
#include "value.h"
#include <string>


#ifndef DOUBLE_VALUE_H
#define DOUBLE_VALUE_H


 
class double_value : public value{
public:

    double_value():value(){}
    
    double_value(value* left, value* right) : value(left->data + right->data, left->name + "d" + right->name, left, right) {}

    void backward () override{
        std::cout<<"Using overided double"<<std::endl;
        if(left!=nullptr)left->grad += grad;
    }
};

#endif
