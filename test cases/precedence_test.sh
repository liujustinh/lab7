#!../bin/rshell
#Test cases used
(echo a && echo b) || (echo c && echo d)
(echo a && echo b) && (echo c && echo d)

(echo a || echo b) && (echo c || echo d)
(echo a || echo b) || (echo c && echo d)
(echo a && echo b) && (echo c; echo d)
(echo a && echo b && echo c) && (echo d || echo e)

(echo a && echo b || echo c) && (echo d && echo e)

(echo a && echo b && echo c) || (echo d && echo e)

(echo a || echo b || echo c) || (echo d || echo e)

(echo a || echo b && echo c) && (echo d || echo e)

