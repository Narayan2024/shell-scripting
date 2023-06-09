#! bin/bash

## Start of the line in any bash script should always be a SHEBANG NOTATION.

## Apart from the first line, none of the lines are considered as shebang
## Shebang notatin should always start with #!

## Using this SHEBANG Notation, we are telling the system the interpretor to use to run this script.

## Your server would have java, go , python, nodejs, shell installed. ( interpretor )

### Now if you run the script, how system will come to know which interpretor it has to use, that's where SHEBANG Notions helps

#### How to run a linux bash script ? 

    # *   bash scriptName.sh 
    # *   sh scriptName.sh 
    # *   ./scriptName

echo  Welcome to Batch54 Cloud DevOps Training

# Pringing Multiple Lines 

echo Line1
echo Line2
echo Line3

# In bash, we have escape sequence characters, using that we can add some power to the echo 

#  \n  : new line
# \t   : tab space                      

echo -e "Line1\nLine2"

echo -e "Line1\t\t\t\t\nLine2"