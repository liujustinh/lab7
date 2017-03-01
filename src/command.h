#ifndef COMMAND_H
#define COMMAND_H

#include <iostream>
#include <vector>
#include <string>
#include <sys/wait.h>
#include <sys/types.h>
#include <stdio.h>
#include <unistd.h>
#include <stdio.h>
#include <cstdio>
#include <cstdlib>
#include <cstring>

    
class Command
{
    private:
        std::string cmd;
    public:
        Command(); 
        Command(std::string a); 
        ~Command();
        int run(); // return -1 if not work
};

#endif