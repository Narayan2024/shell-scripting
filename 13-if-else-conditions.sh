#!/bin/bash 


<<COMMENT
If Command is usually available in 3 forms : 
    
    1) Simple If
    2) If-Else 
    3) Else-If 

1) Simple If :  

    if [ expression ]; then
            commands
    fi 

    Command are going to be executed only if the expression is true. 

* What will happen if the expression fails ? Simple, commands won't be executed.


2) If-Else 

    if [ expression ] ; then
        
        command 1 

    else 

        command 2

    fi

* What will happen if the expression fails ? Simple, commands mentioned in else will be executed.

3) Else-If 

    if [ expression1 ] ; then
        
        command 1 

    elif [ expression2 ] ; then 

        command 2 
    
    elif [ expression3 ] ; then 

        command 3 
    
    else 
        
        command 4

    fi

COMMENT

ACTION=$1 

if [ "$ACTION" == "start" ] ; then 
        echo -e "\e[32m Starting RabbitMQ Service \e[0m"
        exit 0  

elif [ "$ACTION" == "restart" ] ; then
        echo -e "\e[33m restarting RabbitMQ Service \e[0m"
        exit 1  

elif [ "$ACTION" == "stop" ] ; then
        echo -e "\e[33m Stopping RabbitMQ Service \e[0m"
        exit 2  

elif [ "$ACTION" == "enable" ] ; then
        echo -e "\e[33m Enabling RabbitMQ Service \e[0m"
        exit 3  

else 
        echo -e "\e[35m Available option are start --- stop --- restart  --- enable only \e[0m"
        echo -e "\e[33m expected usage :  \n  \t bash $0  start \e[0m "
        exit 4
fi
