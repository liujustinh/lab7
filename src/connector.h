#ifndef CONNECTOR_H
#define CONNECTOR_H

#include "command.h"
#include <iostream>
#include <string>

using namespace std; 

class Connector             //connector header file
{
    protected: 
        string name; 
        Command* one;
        Command* two;
    public:
        Connector() : name("") {};
        virtual void evaluate() = 0;
        virtual string access() = 0; 
};

class AndConnector : public Connector {
    public: 
        AndConnector();
        AndConnector(Command*, Command*);
        void evaluate(); 
        ~AndConnector();
        string access() {
            return name; 
        }
};


class OrConnector : public Connector {
    public:
        OrConnector();
        OrConnector(Command*, Command*);
        ~OrConnector();
        void evaluate(); 
        string access() {
            return name; 
        }
};

class SemiConnector : public Connector {
    public:
        SemiConnector();
        SemiConnector(Command*);
        ~SemiConnector();
        void evaluate();
        string access() {
            return name; 
        }
};

#endif