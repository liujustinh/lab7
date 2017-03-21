#!../bin/rshell
#Test cases used, manual testing

cat < existingInputFile | tr A-Z a-z | tee newOutputFile1 | tr a-z A-Z > newOutputFile2

cat < inputfile

cat < inputfile > outputfile 

cat < inputfile | tee newOutputFile > newOutputFile2

ls < inputfile 

ls > inputfile

cat > inputFIle

ls -l > inputFile

test test.txt > outputFile

[-f test.txt ] > outputFIle

ls | outputFile 

ls < input | tr A-Z a-z > output


