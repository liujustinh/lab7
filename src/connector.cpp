#include "connector.h"
#include "command.h"
using namespace std; 

AndConnector::AndConnector()
{
    name = "&&";
    one = NULL;
    two = NULL;
    connect = NULL;
}

AndConnector::~AndConnector()
{
    name = "";
    one = NULL;
    two = NULL;
    connect = NULL;
}

AndConnector::AndConnector(Base* a, Base* b)
{
    name = "&&"; 
    one = a;
    two = b;
    connect = NULL;
}

AndConnector::AndConnector(Connector* a, Base* b) 
{
    name = "&&"; 
    one = NULL;
    connect = a; 
    two = b; 
}

OrConnector::OrConnector()
{
    name = "||";
    one = NULL;
    two = NULL;
    connect = NULL;
}

OrConnector::~OrConnector()
{
    name = "";
    one = NULL;
    two = NULL;
    connect = NULL;
}

OrConnector::OrConnector(Base* a, Base *b)
{
    name = "||"; 
    one = a;
    two = b;
}

OrConnector::OrConnector(Connector* a, Base *b )
{
    name = "||";
    connect = a;
    one = NULL;
    two = b;
}

SemiConnector::SemiConnector(Base* a)    
{
    name = ";";
    one = a;
}
SemiConnector::SemiConnector()
{
    name = ";";
    one = NULL;
}

SemiConnector::~SemiConnector()
{
    name = "";
    one = NULL;
}


int SemiConnector::evaluate()    //runs the first command while also separating commands
{
    check = one ->run();
    return check;
}

int AndConnector::evaluate()       //checks to see if the first command has run yet and if it has, runs 2nd command
{
    int c;
    if (one != NULL)
    {
        c = one->run(); 
        if (c != -1)
        {
            c = two->run();
        }
    }
    else {
        c = connect->checker();
        if (c != -1)
        {
            c = two->run();
        }
    }
    check = c;
    return c;
    
}


int OrConnector::evaluate()    //checks whether first command has run yet, if it didn't, runs 2nd command
{
    int c;
    if (one != NULL)
    {
        c = one->run();
        if ( c == -1)
        {
            c = two->run();
        }
    }
    else {
        c = connect->checker();
        if (c == -1)
        {
            c = two->run();
        }
    }
    check = c; 
    return c;
}
