#include "command.h"
#include "connector.h"
using std::string;

using namespace std; 


Command::Command() 
{
    cmd = ""; 
}

Command::Command(string a) 
{
    cmd = a; 
}

Command::~Command() 
{
    cmd = ""; 
}

int Command:: run()
{                          //runs a single commands; returns 1 if ran, -1 if did not run
   /*if((cmd.find("|") < 1000) || (cmd.find("<") < 1000) || (cmd.find(">>") < 1000) || (cmd.find(">") < 1000)) 
    {
        vector<int> pipePos;
        vector<int> inputPos; 
        vector<int> outputPos; 
        vector<int> doutputPos; 
        
        for (unsigned a = 0; a < cmd.length() + 1; ++a) 
        {
            if (cmd.at(a) == '|')
            {
                pipePos.push_back(a); 
            }
            if (cmd.at(a) == '<')
            {
                outputPos.push_back(a); 
            }
            if (cmd.at(a) == '>')
            {
                if (cmd.at(a + 1) == '>')
                {
                    doutputPos.push_back(a); 
                    a++;
                }
                else
                {
                    inputPos.push_back(a); 
                }
            }
        }
        return 1; 
    }
    else 
    {*/
        if (cmd == "exit")    //secondary exit command in attempt to fix exit bug
        {
            std::exit(1); 
        }
        
        char** comms = new char*[1000]; 
        string temp = cmd.substr(0,cmd.find(" "));
        char *comm = new char[cmd.length()];
        char *commHold = new char[cmd.length()];
        std::strcpy(comm,temp.c_str());
        
        unsigned j = 0; 
        while (cmd.find(" ") < 1000)
        {
            if( j == 0)
            {
                comms[j] = comm;
                j++;
            }
            else
            {
                temp = cmd.substr(0, cmd.find(" ")); 
                std::strcpy(commHold, temp.c_str());
                comms[j] = commHold; 
                j++;
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
    
        pid_t pid = fork(); 
        
        if (pid == -1)    //fork processes and checks if they are running properly return 1 if works, -1 if does not work
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
        delete[] comms; 
        delete[] comm; 
        delete[] commHold;
        return n; 
}

testCommand::testCommand() 
{
    cmd = ""; 
    flag = 'e'; 
}

testCommand::testCommand(string a) 
{
    cmd = a; 
    flag = 'e'; 
}

testCommand::~testCommand() 
{
    cmd = " "; 
    flag = ' '; 
}

void testCommand::checkFlags() 
{
    if (cmd.find("-f") < 1000) 
    {
        flag = 'f'; 
    }
    else if (cmd.find("-d") < 1000) 
    {
        flag = 'd'; 
    }
    else 
    {
        flag = 'e'; 
    }
}

void testCommand::getDir() 
{
    if (cmd.find("[") < 1000)
    {
        cmd = cmd.substr(cmd.find("[") + 2);
    }
    if (cmd.find("]") < 1000) 
    {
        cmd = cmd.substr(0, cmd.length() - 2); 
    }
    string temp = cmd; 
    unsigned checker = 0; 
    for (unsigned i = 0; i < temp.length(); ++i) 
    {
        if (isspace(temp.at(i)))
        {
            ++checker; 
        }
    }
    for (unsigned a = 0; a < checker; ++a) 
    {
        temp = temp.substr(temp.find(" ") + 1); 
    }
    dir = temp; 
}

int testCommand::run() 
{
    checkFlags(); 
    getDir(); 
    char* directory = new char[dir.length()]; 
    std::strcpy(directory, dir.c_str());
    struct stat sb; 
    if (stat(directory, &sb) == -1) 
    {
        perror("Stat error");
        return -1; 
    }
    
    if (flag == 'e') 
    {
        switch(sb.st_mode & S_IFMT) 
        {
            case S_IFREG: cout << "(True)" << endl; return 1; 
            case S_IFDIR: cout << "(True)" << endl; return 1;
        }
    }
    
    if (flag == 'f') 
    {
        switch(sb.st_mode & S_IFMT) 
        {
            case S_IFREG: cout << "(True)" << endl; return 1; 
            default: cout << "(False)" << endl; return 1; 
        }
    }
    
    if (flag == 'd') {
        switch(sb.st_mode & S_IFMT) 
        {
            case S_IFDIR: cout << "(True)" << endl; return 1; 
            default: cout << "(False)" << endl; return 1; 
        }
    }
    return 0;
}


minishell::minishell(string a)      
{
    unsigned boundary;
    cmd = a; 
    if (cmd == "exit") 
    {                             
            cout << "Exit command entered" << endl;                
            exit(0);
        }
        if (cmd.find("exit") == string::npos)               
        {
            boundary = cmd.size();
        }
        else
        {
            boundary = cmd.find("exit");
        }
        
        unsigned i = 0;
        for (unsigned j = 0; j < boundary; j++)         
        {
            if (cmd.at(j) == ';')
            {
                createCommands(cmd.substr(i,j - i));
                connectors.push_back(new SemiConnector());
                i = j + 2;
                j = i;
            }
            else if (j == (boundary - 1))
            {
                createCommands(cmd.substr(i,j + 1));
                continue; 
            }
            else if (cmd.at(j) == '#')
            {
                for (unsigned k = j; k < boundary; ++k) 
                {
                    if (cmd[k] == ';' && (k != (boundary - 1))) 
                    {
                        i = k + 2;
                        j = k + 2;
                    }
                    else 
                    {
                        j = boundary;
                    }
                }
            }
            else if (cmd.find("(") == j)
            {
               if (i  != j)
                {
                    createCommands(cmd.substr(i, j - i - 2 ));
                    i = j;
                }
                if (cmd.find(")") > 1000)
                {
                    cout << "Missing closing parentheses" << endl;
                    break;
                }
                else
                {
                    createCommands(cmd.substr(i,cmd.find(")") - i + 1));
                    i = cmd.find(")") + 2;
                }
            }
            else if ((cmd.find("test") == j ) || ((cmd.find("[") == j)))
            {
                if (i != j)
                {
                    createCommands(cmd.substr(i, j - i - 2 ));
                    i = j;
                }
                for (unsigned k = j; k < boundary; ++k) 
                {
                    if ((cmd[k] == ';') || (k == (boundary - 1)) || (cmd[k] == ']')) 
                    {
                        createCommands(cmd.substr(i,k - i + 1));
                        i = k + 2;
                        j = k + 2;
                        break;
                    }
                }
            }
        }
        
        if (boundary != cmd.size())
        {
            commands.push_back(new Command("exit"));
        }
}

void minishell::createCommands(string a) 
{
    do                                       //also creates connector classes (And/Or) to be added to the vector of connectors
    {
        unsigned n = a.find("||"); 
        unsigned m = a.find("&&"); 
        unsigned o = a.find("]");
        unsigned p = a.find(")");
        unsigned q = a.find("(");
        if (q < 1000)
        {
            if (m > 1000 && n > 1000)
            {
                commands.push_back(new minishell(a.substr(1, a.length() - 2)));
                a.clear();
            }
            else if (n < 1000 )
            {
                if ((q > n) && (m > 1000))
                {
                    connectors.push_back(new OrConnector());
                    commands.push_back(new minishell(a.substr(q, p - q)));
                    a.erase(0, p + 1);
                }
                else if ((m < 1000) && (m < q))
                {
                    connectors.push_back(new AndConnector());
                    commands.push_back(new minishell(a.substr(q + 1, p - (q + 1))));
                    a.erase(0,p + 1);
                }
                else if(( m < 1000) && (m > q) && (n < q))
                {
                    connectors.push_back(new OrConnector());
                    commands.push_back(new minishell(a.substr(q + 1, p - (q + 1))));
                    a.erase(0,p + 1);
                }
                else 
                {
                    commands.push_back(new minishell(a.substr(1,p - 1)));
                    a.erase(0, p + 1);
                }
            }
            else if (m < 1000)
            {
                if (q > m)
                {
                    connectors.push_back(new AndConnector());
                    commands.push_back(new minishell(a.substr(q + 1, p - q - 1 )));
                    a.erase(0, p + 1);
                }
                else if (q < m)
                {
                    commands.push_back(new minishell(a.substr(q + 1, p - 1)));
                    a.erase(0, p + 1);
                }
                
            }
        }
        else if (a.find("test") < 1000)
        {
            if (n < 1000)
            {
                commands.push_back(new testCommand(a.substr(a.find("test"), n - 1)));
                a.erase(a.find("test"), n + 3);
            }
            else if (m < 1000)
            {
                commands.push_back(new testCommand(a.substr(a.find("test"), m - 1)));
                a.erase(a.find("test"), m + 3);
            }
            else
            {
                commands.push_back(new testCommand(a));
                a.clear();
            }
        }
        else if ((n > 1000) && (m > 1000) && (o > 1000))
        {
                commands.push_back(new Command(a)); 
                a.erase(0,a.length());
        }
        else if (n < 1000)
        {
            if( o > 1000)
            {
                if(m > 1000)
                {
                    connectors.push_back(new OrConnector());
                    if (n != 0) 
                    {
                        commands.push_back(new Command(a.substr(0, n - 1)));
                        a.erase(0, n + 3);
                    }
                    else
                    {
                        commands.push_back(new Command(a.substr(3, a.length())));
                        a.erase(0, a.length());
                    }
                }
                else if (m < 1000)
                {
                    if(n > m)
                    {
                        connectors.push_back(new AndConnector());
                        if (m != 0 ) 
                        {
                            commands.push_back(new Command(a.substr(0, m - 1)));
                            a.erase(0, m + 3);
                        }
                        else
                        {
                            commands.push_back(new Command(a.substr(3, n - 3)));
                            a.erase(0, n);
                        }
                    }
                    else if ( n < m )
                    {
                        connectors.push_back(new OrConnector());
                        if (n != 0) 
                        {
                            commands.push_back(new Command(a.substr(0, n - 1)));
                            a.erase(0, n + 3);
                        }
                        else
                        {
                            commands.push_back(new Command(a.substr(3, a.length())));
                            a.erase(0, m);
                        }
                    }
                }
            }
            else
            {
                connectors.push_back(new OrConnector());
                commands.push_back(new testCommand(a.substr(1, n - 2)));
                a.erase(0, n + 3);
            }
        }
        else if (m < 1000) 
        {
            if(o > 1000)
            {
                if(m != 0)
                {
                    commands.push_back(new Command(a.substr(0, m))); 
                    connectors.push_back(new AndConnector()); 
                    a.erase(0, m + 3);
                }
                else
                {
                    commands.push_back(new Command(a.substr(3,a.length())));
                    connectors.push_back(new AndConnector());
                    a.erase(0, a.length());
                }
            }
            else
            {
                connectors.push_back(new AndConnector());
                commands.push_back(new testCommand(a.substr(1, n-2)));
                a.erase(0, n + 3);
            }
        }
        else if (o < 1000)
        {
            commands.push_back(new testCommand(a.substr(2, o - 3)));
            a.erase(0, o + 1);
        }
    } 
    while ((a.find("||") < 1000) || (a.find("&&") < 1000) || (a.find("]") < 1000)|| (a.find(")") < 1000));
    
    if(!a.empty())
    {
        commands.push_back(new Command(a)); 
    }
}

int minishell::run() 
{
    int n = -1; 
    vector<Connector*> hold; 
    hold.push_back(new SemiConnector());
    while(connectors.size() != 0 )                  //runs each command in accordance to the connector (if any) 
    {
        if(connectors.at(0)->access() == ";")
        {
            if(!(commands.empty()))
            {
                SemiConnector* a = new SemiConnector(commands.at(0));
                a ->evaluate();
                connectors.erase(connectors.begin());
                commands.erase(commands.begin());
                hold.push_back(a);
            }
            else
            {
                connectors.erase(connectors.begin());
            }
        }
         else if(connectors.at(0)->access() == "&&")
        {
            if((hold.back()->access() == "&&") || (hold.back()->access() == "||"))
            {
                AndConnector* b = new AndConnector(hold.back(),commands.at(0));
                b ->evaluate();
                commands.erase(commands.begin());
                hold.push_back(b);
            }
            else
            {
                AndConnector* b = new AndConnector(commands.at(0),commands.at(1));
                b->evaluate();
                commands.erase(commands.begin());
                commands.erase(commands.begin());
                hold.push_back(b);
            }
            connectors.erase(connectors.begin());
        }
        else if(connectors.at(0)->access() == "||")
        {
            if((hold.back()->access() == "&&") || (hold.back()->access() == "||"))
            {
                OrConnector* c = new OrConnector(hold.back(),commands.at(0));
                c->evaluate();
                commands.erase(commands.begin());
                hold.push_back(c);
            }
            else
            {
                OrConnector* c = new OrConnector(commands.at(0),commands.at(1));
                c->evaluate();
                commands.erase(commands.begin());
                commands.erase(commands.begin());
                hold.push_back(c);
            }
            connectors.erase(connectors.begin());
        }
    }
    n = hold.back()->checker(); 
    
    hold.clear();
    
    while(commands.size() != 0)
    {
        commands.front()->run();
        commands.erase(commands.begin());
    }
    return n; 
    
}






