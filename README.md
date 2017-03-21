# RShell


 by Edmund Fund and Justin Liu

This program takes a user input as an individual command that will be executed through usr/bin.
To achieve this, the program takes the user input and parses the input, separating commands and connectors. Once it has initialized its
vector of commands and connectors, the program executes these commands in order while also following the order of operations
set by the connectors. 


##Bugs

###Bugs Involving Test:
-when calling test command with [] within precedence operators (), the program can parse the test command incorrectly
-when calling test command within precedence operators, the program can parse the commands used within the same precedence parantheses incorrectly


###Bugs with Connector:
-andConnector/orConnector: when used with certain commands, can cause the program to fork too many processes(?) or 
    it can cause the system to not be able to retrieve hostname or bugs the exit command
-if a command is called with ";" at the end, there can be an out-of-bounds error
-when exit is used in conjunction with multipled connectors, it will sometimes not run 

###Bugs with Exit: 
-exit: sometimes the exit command does not exit the program properly, requiring multiple user inputs of exit. (see above for error with connectors)
-exit when used in front of echo (i.e. echo exit) will not print exit to system but instead exits program
-sometimes when exit is used after an OrConnector, it will run when it is not supposed to

###Bugs with Precedence: 
-the program can create extra commands or parse wrong if precedence operator is used within a precedence operator (i.e. (echo hi && (echo a && echo b)) && echo test

###Bugs with Commented Commands:
-when calling an existing function and having a commented argument provided to the function, the function will take in the commented command as its parameter when it's not supposed to

###Bugs with Input/Output Redirection and Piping:
-when calling multiple input/output redirection together with pipes, the program would crash
-cannot handle output redirection
-does not work with parantheses aka precendence operators
-does not work with test
