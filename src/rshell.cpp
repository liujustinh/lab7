#include "rshell.h"
using namespace std; 

void rshell::run() 
{
    string input; 
    while (input != "exit")        //run infinitely until user inputs "exit" (bugged/needs fixing)
    {
        char hostname[256] = {0};     
            
        if (gethostname(hostname, sizeof(hostname) - 1) != 0)   //get hostname/workspace of user
        {
            perror("gethostname() error");
        }
                                  
        cout << "@" << hostname;
        cout << "$"; 
        getline(cin, input); 
        if (input == "exit")
        {                              //first exit (bugged?)
            cout << "Exit command entered" << endl;                
            exit(0);
            break; 
        }
        
        unsigned i = 0;
        for (unsigned j = 0; j < input.size(); j++)          //creates semiConnectors to separate each command
        {
            if (input.at(j) == ';')
            {
                createCommands(input.substr(i, j - i));
                connectors.push_back(new SemiConnector());
                i = j + 2;
                j = i;
            }
            else if (j == (input.size() - 1))
            {
                createCommands(input.substr(i, j + 1));
                continue; 
            }
            else if (input.at(j) == '#')                 //accounts for commented commands 
            {
                for (unsigned k = j; k < input.size(); ++k) {
                    if (input[k] == ';' && (k != (input.size() - 1))) {
                        i = k + 2;
                        j = k + 2;
                    }
                    else 
                    {
                        j = input.size();
                    }
                }
            }
            else if (input.find("(") == j)                //checks for precedence operators 
            {
               if (i != j)
                {
                    createCommands(input.substr(i, j - i - 2 ));
                    i = j;
                }
                if (input.find(")") > 1000)
                {
                    cout << "Missing closing parentheses" << endl;
                    break;
                }
                else
                {
                    createCommands(input.substr(i, input.find(")") - i + 1));
                    i = input.find(")") + 2;
                    j = input.find(")") + 2;
                }
            }
            else if ((input.find("test") == j ) || ((input.find("[") == j)))   //checks for if user called test commands
            {
                if (i  != j)
                {
                    createCommands(input.substr(i, j - i - 2 ));
                    i = j;
                }
                if(input.find('/') > 1000)
                {
                    cout << "Error: not enough arguments or arguments inputted incorrectly" << endl;
                    break;
                }
                for (unsigned k = j; k < input.size(); ++k) 
                {
                    if ((input[k] == ';') || (k == (input.size() - 1)) || (input[k] == ']')) 
                    {
                        createCommands(input.substr(i, k - i + 1));
                        i = k + 2;
                        j = k + 2;
                        break;
                    }
                }
            }
        }
        
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
                    AndConnector* b = new AndConnector(hold.back(), commands.at(0));
                    b ->evaluate();
                    commands.erase(commands.begin());
                    hold.push_back(b);
                }
                else
                {
                    AndConnector* b = new AndConnector(commands.at(0), commands.at(1));
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
                    OrConnector* c = new OrConnector(hold.back(), commands.at(0));
                    c->evaluate();
                    commands.erase(commands.begin());
                    hold.push_back(c);
                }
                else
                {
                    OrConnector* c = new OrConnector(commands.at(0), commands.at(1));
                    c->evaluate();
                    commands.erase(commands.begin());
                    commands.erase(commands.begin());
                    hold.push_back(c);
                }
                connectors.erase(connectors.begin());
            }
        }
        hold.clear();
        
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
            else if (n < 1000)
            {
                if ((q > n) && (m > 1000))
                {
                    connectors.push_back(new OrConnector());
                    commands.push_back(new minishell(a.substr(q, p - q)));
                    a.erase(0,p + 1);
                }
                else if (( m < 1000) && (m < q))
                {
                    connectors.push_back(new AndConnector());
                    commands.push_back(new minishell(a.substr(q + 1, p - (q + 1))));
                    a.erase(0,p + 1);
                }
                else if (( m < 1000) && (m > q) && (n < q))
                { 
                    connectors.push_back(new OrConnector());
                    commands.push_back(new minishell(a.substr(q + 1, p - (q + 1))));
                }
                else 
                {
                    commands.push_back(new minishell(a.substr(1, p - 1)));
                    a.erase(0, p + 1);
                }
            }
            else if (m < 1000)
            {
                if (q > m)
                {
                    connectors.push_back(new AndConnector());
                    commands.push_back(new minishell(a.substr(q + 1, p - q - 1 )));
                    a.erase(0,p + 1);
                }
                else if (q < m)
                {
                    commands.push_back(new minishell(a.substr(q + 1, p - 1)));
                    a.erase(0,p + 1);
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
            if (o > 1000)
            {
                if ((m < 1000 && n < m) || ( m > 1000))
                {
                    connectors.push_back(new OrConnector());
                    if ( n != 0 ) 
                    {
                        commands.push_back(new Command(a.substr(0, n - 1)));
                        a.erase(0, n + 3);
                    }
                    else
                    {
                        if(m < 1000)
                        {
                            commands.push_back(new Command(a.substr(3,m - 3)));
                            a.erase(0, m + 3);
                        }
                        else
                        {
                            commands.push_back(new Command(a.substr(3,a.length())));
                            a.erase(0,a.length());
                        }
                    }
                }
                else if ( (m < 1000) && (m < n))
                {
                    connectors.push_back(new AndConnector());
                    commands.push_back(new Command(a.substr(0, m - 1)));
                    a.erase(0,m + 3);
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
            if (o > 1000 )
            {
                if (m != 0)
                {
                    commands.push_back(new Command(a.substr(0, m))); 
                    connectors.push_back(new AndConnector()); 
                    a.erase(0, m + 3);
                }
                else
                {
                    commands.push_back(new Command(a.substr(3, a.length())));
                    connectors.push_back(new AndConnector());
                    a.erase(0, a.length());
                }
            }
            else
            {
                connectors.push_back(new AndConnector());
                commands.push_back(new testCommand(a.substr(1, n - 2)));
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
    
    if (!a.empty())
    {
            commands.push_back(new Command(a)); 
    }
}