#include "command.h"

using std::string;

Command::Command() {
    cmd = ""; 
}

Command::Command(string a) {
    cmd = a; 
}

Command::~Command() {
    cmd = ""; 
}

int Command:: run()    //runs a single commands; returns 1 if ran, -1 if did not run
{
    if (cmd == "exit") {    //secondary exit command in attempt to fix exit bug
        std::abort(); 
    }
    char** comms = new char*[1000]; 
    string temp = cmd.substr(0,cmd.find(" "));
    char *comm = new char[cmd.length()];
    char *commHold = new char[cmd.length()];
    std::strcpy(comm,temp.c_str());
    //comms[0] = comm;
    //cmd.erase(0,cmd.find(" "));
    //unsigned i = 0;
    //string temp; 
    unsigned j = 0; 
    while (cmd.find(" ") < 1000) {
        if( j == 0)
        {
            comms[j] = comm;
            j++;
        }
        else{
        temp = cmd.substr(0, cmd.find(" ")); 
       /* if( j == 0)
        {
            strcpy(comm, temp.c_str()); 
            comms[j] = comm;
            j++;
        }
        else if (j != 0)
        {*/
            std::strcpy(commHold, temp.c_str());
            comms[j] = commHold; 
            //strcpy(comms[j], temp.c_str());
            j++;
       // }
        }
        cmd.erase(0,cmd.find(" ") + 1);
    }
    
    if(!cmd.empty())
    {
        temp = cmd;
        char *com = new char[cmd.length()];
        std::strcpy(com,temp.c_str());
        comms[j] = com;
    }
    
    
    comms[j+1] = NULL; 
    int n = 1; 
    /*char* com = new char [cmd.length()];
    strcpy(com,cmd.c_str());*/
    pid_t pid = fork(); 
    
    if (pid == -1)    //fork processes and checks if they are running properly
    {
        perror("Fork failed");
        n = -1; 
    }
    
    else if (pid == 0 && execvp(comm, comms)) 
    {
        perror("Execute failed");
        n = -1; 
        return n;
    }
    
    else if (pid > 0)
    {
        if (wait(0) == -1) 
        {
            perror("Wait failed"); 
            n = -1; 
        }
    }
    delete[] comms; //memory leak
    delete[] comm; //memory leak FIXED
    delete[] commHold;
    return n; 
}
