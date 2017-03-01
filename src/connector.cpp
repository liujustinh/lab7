#include "connector.h"

using namespace std; 

AndConnector::AndConnector(){
    name = "&&";
    one = NULL;
    two = NULL;
}

AndConnector::~AndConnector(){
    name = "";
    one = NULL;
    two = NULL;
}

AndConnector::AndConnector(Command* a, Command* b) {
    name = "&&"; 
    one = a;
    two = b;
}

OrConnector::OrConnector(){
    name = "||";
    one = NULL;
    two = NULL;
}

OrConnector::~OrConnector(){
    name = "";
    one = NULL;
    two = NULL;
}
OrConnector::OrConnector(Command* a, Command *b) {
    name = "||"; 
    one = a;
    two = b;
}


void AndConnector::evaluate()       //checks to see if the first command has run yet and if it has, runs 2nd command
{
    int c = one->run(); 
    if(c != -1)
    {
        two->run();
    }
}


void OrConnector::evaluate()    //checks whether first command has run yet, if it didn't, runs 2nd command
{
    int c = one->run();
    if( c == -1)
    {
        two->run();
    }
}

SemiConnector::SemiConnector(Command* a)    
{
    name = ";";
    one = a;
    two = NULL;
}

void SemiConnector::evaluate()    //runs the first command while also separating commands
{
    one->run();
}

SemiConnector::SemiConnector()
{
    name = ";";
    one = NULL;
    two = NULL;
}

SemiConnector:: ~SemiConnector()
{
    name = "";
    one = NULL;
    two = NULL;
}


