#ifndef CONNECTOR_H
#define CONNECTOR_H

#include "command.h"
#include <iostream>
#include <string>

using namespace std; 

class Command; 

class Connector             //connector header file
{
    protected: 
        string name; 
        Base* one;
        int check; 
    public:
        Connector() : name("") {};
        virtual int evaluate() = 0;
        virtual string access() = 0; 
        virtual int checker() = 0;
};

class AndConnector : public Connector 
{
    protected:
        Connector* connect;         //like the OrConnector, holds pointer to connector/command to see if the command before it ran
        Base* two;
    public: 
        AndConnector();
        AndConnector(Base*, Base*);
        AndConnector(Connector*, Base*);
        int evaluate(); 
        ~AndConnector();
        string access() {
            return name; 
        }
        int checker() {
            return check; 
        }
};


class OrConnector : public Connector 
{
    protected:
        Connector* connect;
        Base* two;
    public:
        OrConnector();
        OrConnector(Base*, Base*);
        OrConnector(Connector*, Base*); 
        ~OrConnector();
        int evaluate(); 
        string access() {
            return name; 
        }
        int checker() {
            return check; 
        }
};

class SemiConnector : public Connector 
{
    public:
        SemiConnector();
        SemiConnector(Base*);
        ~SemiConnector();
        int evaluate();
        string access() 
        {
            return name; 
        }
        int checker()
        {
            return check;
        }
};


#endif