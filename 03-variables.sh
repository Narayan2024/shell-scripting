#!/bin/bash

# What is a variable ? Variable is used to store and pass values 
# a=10
# name=Verma
# batch=54
# topic=shellScripting

# In bash there is no concept of Data Types : By default everything is a string
# int a = 10 
# string b = Manu 
# float c = 0.15

# This is how we can declare variables in Bash 
a=10 
b=20
c=30

# Syntax : $variableName : $ is going to print the value of the variable
echo $a 
echo -e "Value of the variable a is $a"
echo -e "Value of the variavle b is \e[32m $b \e[0m"
echo -e "Value of the variable c is \e[32m $c \e[0m"
echo -e "Value of the variable d is \e[32m $d \e[0m"

# If you try to print a variable that is not declared, bash will consider that as a null rather an error 

# rm -rf /data/${FOLDER_TO_DELETE}/ => rm -rf /data

# "Double Quotes "
# 'Single Quotes'
