#include "rshell.h"
#include "connector.h"
#include "command.h"

using namespace std; 

void rshell::run() {
    string input; 
    while (input != "exit")        //run infinitely until user inputs "exit" (bugged/needs fixing)
    {
        //char login[256] = {0};        
        char hostname[256] = {0};     
        
        /*getlogin_r(login, sizeof(login) - 1);    //get user login to display for extra credit :)
        {
            perror("getlogin_r error");
        }   */ 
            
        if(gethostname(hostname, sizeof(hostname)-1) != 0)   //get hostname/workspace of user
        {
            perror("gethostname() error");
        }
                                  //displays hostname
        cout << "@" << hostname;
        cout << "$"; 
        getline(cin, input); 
        if (input == "exit") {                              //first exit (bugged?)
            cout << "Exit command entered" << endl;                
            abort(); 
        }
        unsigned boundary;
        if(input.find("exit") == string::npos)               //reduces input size to end at start of "exit" found in input
        {
            boundary = input.size();
        }
        else
        {
            boundary = input.find("exit");
        }
        
        unsigned i = 0;
        for (unsigned j = 0; j < boundary; j++)          //creates semiConnectors to separate each command
        {
            if(input.at(j) == ';')
            {
                createCommands(input.substr(i,j));
                connectors.push_back(new SemiConnector());
                i = j + 2;
                j = i;
               
            }
            else if(j == (boundary - 1))
            {
                createCommands(input.substr(i,j + 1));
                continue; 
            }
            else if(input.at(j) == '#')
            {
                for (unsigned k = j; k < boundary; ++k) {
                    if (input[k] == ';' && (k != (boundary) - 1)) {
                        i = k + 2;
                        j = k + 2;
                    }
                    else 
                    {
                        j = boundary;
                    }
                }
            }
        }
        
        /*if (connectors.at(connectors.size() - 1)->access() == ";") {
            connectors.pop_back(); 
        }*/
        
        if( boundary != input.size())
        {
            commands.push_back(new Command("exit"));
        }
        
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
            }
            else
            {
                connectors.erase(connectors.begin());
            }
        }
        else if(connectors.at(0)->access() == "&&")
        {
            AndConnector* b = new AndConnector(commands.at(0),commands.at(1));
            b->evaluate();
            connectors.erase(connectors.begin());
            commands.erase(commands.begin());
            commands.erase(commands.begin());
        }
        else if(connectors.at(0)->access() == "||")
        {
            OrConnector* c = new OrConnector(commands.at(0),commands.at(1));
            c->evaluate();
            connectors.erase(connectors.begin());
            commands.erase(commands.begin());
            commands.erase(commands.begin());
        }
    }
    
    while(commands.size() != 0)
    {
        commands.front()->run();
        commands.erase(commands.begin());
    }
    }
    

}

void rshell::createCommands(string a) {     //is passed in a substring of user input and converts it to a command object to be added to the connector vector
    do                                       //also creates connector classes (And/Or) to be added to the vector of connectors
    {
        unsigned n = a.find("||"); 
        unsigned m = a.find("&&"); 
        if ((n > 1000) && (m > 1000))
        {
            commands.push_back(new Command(a)); 
            a.erase(0,a.length());
        }
        else if ( n < 1000)
        {
            if ((m < 1000 && n < m) || ( m > 1000))
            {
                connectors.push_back(new OrConnector());
                commands.push_back(new Command(a.substr(0,n)));
                a.erase(0, n + 3);
            }
            else if ( (m < 1000) && (m < n))
            {
                connectors.push_back(new AndConnector());
                commands.push_back(new Command(a.substr(0,m)));
                a.erase(0,m + 3);
            }
            
            
        }
        else if (m < 1000) 
        {
            connectors.push_back(new AndConnector()); 
            commands.push_back(new Command(a.substr(0, m))); 
            a.erase(0, m + 3); 
        }
        
        
    } while ((a.find("||") < 1000) || (a.find("&&") < 1000));
    if(!a.empty())
    {
    commands.push_back(new Command(a)); 
    }
}
