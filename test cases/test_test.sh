#!../bin/rshell
#Test cases used:

test main.txt 
test -e /bin 
test -f /bin 
test -d /src/main.cpp
test nonfile
test -e nonfile 
test -f nonfile 
test -d nonfile 
test /bin #just
test -e /bin #a
test -f /bin #test
test -d /bin #case
test /src/bin #this
test -e /src/main.cpp #is
test -f /src/nonfile #just
test -d /src/nonfile #a
test src #test
test -e /src #case
test -f /src #this
test -d src #is
test /src/nonfolder/nonfile #just
test -e /src/nonfolder/nonfile #a
test -f /src/nonfolder/nonfile #test
test -d /src/nonfolder/nonfile #case
test #main.txt
test -e #main.cpp
test -f #main.cpp
test -d #/bin
test /src/main.txt
test -e /bin/#swag
test #/bin

[ -e /bin ] 
[ -f /bin ]
[ -d /bin ]

[ /bin ] 
[ /src/rshell.cpp ]

[ -f /src/main.cpp ]
[ -d /src/main.cpp ]


