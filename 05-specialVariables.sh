#!/bin/bash 

# Special variables gives special properties to your variables 

# Here are few of the special variables :  $0 to $9 , $? ,  $#,  $* , $@ 

echo $0     # $0 prints the script name you are executing 
echo "Name of the script executed is $0"
echo "Name of the Trainer is $1"
echo "Training Batch Number is $2"
echo "Current Topics is $3" 

# We can supply the values from the command line 

# bash scriptName.sh 100   200   300    ( like this you can supply a maximum of 9 variables from the command line)
#                     $1    $2    $3  

echo $*    # $* is going to print the used variables  
echo $@    # $@ is going to print the used variables  
echo $$    # $$ is going to print the PID of the current proces 
echo $#    # $# is going to print the number of arguments
echo $?    # $? is going to print the exit code of the last command.