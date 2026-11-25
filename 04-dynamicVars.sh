#!/bin/bash 

# TODAYS_DATE="03JUNE2023"                                                # HardCoding a value makes it consistent
TODAYS_DATE=$(date +%F)                    
NO_OF_SESSIONS=$(who | wc -l)                                         # Always enclose expresssions in paranthesis
echo -e "Good Morning and todays date is \e[32m $TODAYS_DATE \e[0m"
echo -e "Number of opened sessions : \e[32m $NO_OF_SESSIONS \e[0m"   

Todays_date=$(date +F%)
No_of_sessions=$(who | wc -l)
echo -e "Good Evening and today date is \e[31m $Todays_date \e[0m"
