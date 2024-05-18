#include "value.h"
#include "add_value.h"
#include "double_value.h"


  
value::value() : data(0), grad(0), left(nullptr), right(nullptr) {}


  
value::value(double dat){ value v=double_value(); v.data=dat; *this=v; }

 
value::value(double dat, const std::string& nam, value* lft, value* rgt)
    : data(dat), name(nam), left(lft), right(rgt), grad(0) {}

bool value::operator<(const value& other) const {
    return data < other.data;
} 


value value::operator +(value &other){
    return add_value(this, &other);
}


void value::print() {
    std::cout<<name<<": "<<data<<" grad:"<<grad<<'\n';
    if(left!=nullptr){
        left->print();
    }
    if(right!=nullptr){
        right->print();
    }
}

void value::dfs(std::vector<value>&toposort,std::set<value>&visited){
    visited.insert(*this);
    if(left!=nullptr && visited.find(*left)==visited.end()){
        left->dfs(toposort,visited);
    }
    if(right!=nullptr && visited.find(*right)==visited.end()){
        right->dfs(toposort,visited);
    }
    toposort.push_back(*this);
}

void value::backpropagate(){
    grad=1.0;
    std::vector<value> toposort;
    std::set<value> visited;

    dfs(toposort,visited);


    for(auto it:toposort){
        std::cout<<it.data<<std::endl;
    }

    for(int i=toposort.size()-1;i>=0;i--){
        toposort[i].backward();
    }
}