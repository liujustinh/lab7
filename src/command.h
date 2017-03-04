#ifndef COMMAND_H
#define COMMAND_H

#include <iostream>
#include <vector>
#include <string>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <unistd.h>
#include <stdio.h>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <vector>

using std::string;

class Connector; 

class Base 
{
    protected: 
        string cmd; 
    public: 
        Base() 
        {
            cmd = ""; 
        }
        Base(string a) 
        {
            cmd = a; 
        }
        ~Base() 
        {
            cmd = ""; 
        }
        virtual int run() = 0; 
        virtual string getCmd() = 0; 
};
    
class Command : public Base 
{
    public:
        Command();
        Command(string a);
        ~Command();
        int run(); // return -1 if not work
        string getCmd() 
        {
            return cmd; 
        }
};

class testCommand : public Base 
{
    protected: 
        char flag; 
        string dir; 
    public: 
        testCommand();
        testCommand(string a);
        ~testCommand(); 
        void checkFlags(); 
        void getDir(); 
        int run(); 
        string getCmd(){
            checkFlags();
            getDir();
            return cmd + ' ' + flag + ' ' + dir + '\n';
        }
};

class minishell : public Base 
{                   //parantheses shell; pretty much an rshell within an rshell for evaluating parantheses
    protected: 
        std::vector<Base*> commands; 
        std::vector<Connector*> connectors; 
    public: 
        minishell() {}; 
        minishell(string a); 
        int run();                             //return 1 if ran, -1 if did not
        void createCommands(string a); 
        string getCmd() 
        {
            return cmd; 
        }
        string access() 
        {
            return "()"; 
        }
};

#endif