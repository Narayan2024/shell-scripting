#!/bin/bash 

# Syntax for CASE 
# case  $var in 
#     opt1) command1 ;; 
     
#     opt2) command2 ;;

# esac

ACTION=$1

case $ACTION in                                                   # The value of action will be taken from the command line as first argument.
    start) 
        echo -e "\e[32m Starting RabbitMQ Service \e[0m"
        exit 0
        ;;
    stop) 
        echo -e "\e[31m Stopping RabbitMQ Service \e[0m"
        exit  1
        ;;
    restart) 
        echo -e "\e[33m Restarting RabbitMQ Service \e[0m"
        exit 2
        ;;
    *)
        echo -e "\e[36m Possible values are start or stop or restart only \e[0m"
        exit 3
        ;;

esac 


#  exit : exit command helps us to take the script executing out of the script.