# RShell


 by Edmund Fund and Justin Liu

This program takes a user input as an individual command that will be executed through usr/bin.
To achieve this, the program takes the user input and parses the input, separating commands and connectors. Once it has initialized its
vector of commands and connectors, the program executes these commands in order while also following the order of operations
set by the connectors. 


##Bugs
-Program can malfunction when multiple connectors are chained together

###Bugs Involving Test:

-commands using in certain orders with connectors can cause the program to not execute the commands properly
-Sometimes commands would not execute properly with andConnector and orConnector being used.

###Bugs with Connector:
-andConnector/orConnector: when used with certain commands, can cause the program to fork too many processes or 
    it can cause the system to not be able to retrieve hostname. 
    -can also 
-if a command is called with ";" at the end, there can be an out-of-bounds error
###Bugs with cd:
-cd: can cause a segmentation fault in some cases.

###Bugs with Exit: 
-exit: sometimes the exit command does not exit the program properly, requiring multiple user inputs of exit.