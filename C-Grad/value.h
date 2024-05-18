#include <iostream>
#include <string>
#include <vector>
#include <set>

#ifndef VALUE_H
#define VALUE_H


class value{
public:

    double data;
    double grad;
    std::string name;
    value* left;
    value* right;

    value();
    value(double dat);
    value(double dat, const std::string& nam, value* lft, value* rgt);
    
    bool operator<(const value& other) const;

    value operator +( value &other);
    value operator -( value &other);
    value operator *( value &other);
    value operator /( value &other);
    value operator ^( value &other);
    
    virtual void backward();
    void reset_grad();

    void print();

    void dfs(std::vector<value>&toposort,std::set<value>&visited);

    void backpropagate();
};


#endif
