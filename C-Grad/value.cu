#include "value.h"
#include <random>

std::random_device rd; 
std::mt19937 gen(rd());

long long random(long long l,long long r){
    return std::uniform_int_distribution<int>(l,r)(gen);
}

  
value::value() : data(0), grad(0), left(nullptr), right(nullptr),id(random(0,1e18)) {}

value::value(double dat): data(dat), name("."), left(nullptr), right(nullptr), grad(0),id(random(0,1e18)){}

value::value(double dat, const std::string& nam, value* lft, value* rgt)
    : data(dat), name(nam), left(lft), right(rgt), grad(0),id(random(0,1e18)) {}



bool value::operator<(const value& other) const {
    if(id!=other.id)return id<other.id;
    return data < other.data;
} 

bool value::operator==(const value& other) const {
    return (id==other.id) && (data==other.data);
} 


value value::operator +(value &other){
    return value(data + other.data,"+", this,&other); 
}

value value::operator *(value &other){
    return value(data * other.data,"*", this,&other); 
}



void value::backward(){
    if(this->name=="."){
        if(left!=nullptr)left->grad+=grad;
        return;    
    } 
    if(this->name=="+"){
        std::cout<<"sum"<<std::endl;
        left->grad+=grad;
        right->grad+=grad;
        return;
    }
    if(this->name=="*"){
        std::cout<<"multi"<<std::endl;
        left->grad+=grad*right->data;
        right->grad+=grad*left->data;
        return;
    }
}


void value::print() {
    std::cout <<name<<": "<< data << " grad:"<<grad<<std::endl;
    if(left!=nullptr){
        left->print();
    }
    if(right!=nullptr){
        right->print();
    }
}

void value::dfs(std::vector<value*>&toposort,std::set<value*>&visited){
    visited.insert(this);
    if(left!=nullptr && visited.find(left)==visited.end()){
        left->dfs(toposort,visited);
    }
    if(right!=nullptr && visited.find(right)==visited.end()){
        right->dfs(toposort,visited);
    }
    toposort.push_back(this);
}

void value::backpropagate(){
    grad=1.0;
    std::vector<value*> toposort;
    std::set<value*> visited;

    dfs(toposort,visited);


    for(auto it:toposort){
        std::cout<<(*it).data<<std::endl;
    }

    for(int i=toposort.size()-1;i>=0;i--){
        toposort[i]->backward();
    }
}