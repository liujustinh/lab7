#ifndef RSHELL_H
#define RSHELL_H

#include "connector.h"
#include "command.h"
#include <iostream>
#include <vector>
#include <string>
#include <cstring>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <cstdlib>
#include <fcntl.h>

using namespace std; 

class rshell 
{  
    protected: 
        vector<Base*> commands;    //container of commands
        vector<Connector*> connectors;  //container of connectors
    public:
        rshell() : commands(0), connectors(0) {};
        void run(); 
        void createCommands(string a); 
};

#endif 