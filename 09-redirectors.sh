#!/bin/bash

# Redirectors are of 2 types in bash 
#     1) Input Redirector   ( Means take input from the file )        :    <   ( Ex : sudo mysql </tmp/studentapp.sql )
#     2) Output Redirector  ( Means routing the output to a file )    :    > or 1>    >>  ( >> appends the latest output to the existing content)

# Outputs :  
#     1) Standout Output 
#     2) Standout Error                                               : 2> captures only the standard error   
#     3) Standout output and error                                    : &> This captures both errors and standard output 

ls -ltr    >   op.txt   # Redirects the output to the op.txt file 
ls -ltr   >>   op.txt   # Redirects the output  to op.txt file by appending to the existing content
ls -ltr   &>   op.txt   # Redirects both standardOut and standardErrors 
ls -ltr   2>   op.txt   # Redirects only the standard errors.


# Each and every action in linux will have an exit which determines the status of the completion,
# Range of exit codes is 0 to 255 
# 0         :  successful 
# 1-255     :  partial failure or comple failure or partial sucess. 

# How to do I come to know the exit code of the previously executed command ? ? ? 
# $?    


# Exit codes also plays a key role in debugging big scripts.

# Ex : If you're having a big script and if your script fails and it's really challenging to figure out the mistake as it makes us to watch over the entie script from the beginning.
# Instead, we can use exit codes everyWhere to find out where our script failes.
