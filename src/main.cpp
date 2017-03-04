#include "rshell.h"    //FIX THE INCLUDES
#include <string>

using namespace std;

int main() 
{
    rshell* a = new rshell(); //create/intialize a new shell
    a->run(); //run shell until exit command is called
    return 0;
}