#!/bin/bash

if [ ! -f "~/.bash_custom" ]
then
    touch ~/.bash_custom
fi

# If source ~/.bash_custom is not in ~/.bashrc, add it
if ! grep -q "source ~/.bash_custom" ~/.bashrc
then
    echo "source ~/.bash_custom" >> ~/.bashrc
fi

# If parameter --add/-a is passed, add the alias to the file
if [ "$1" == "--add" ] || [ "$1" == "-a" ]
then

    # If the alias already exists, exit
    if grep -q "alias $2='sudo $2'" ~/.bash_custom
    then
        echo "Alias $2 already exists in ~/.bash_custom"
    fi

    echo "alias $2='sudo $2'" >> ~/.bash_custom
    echo "Added alias $2 to ~/.bash_custom"
fi

# If parameter --remove/-r is passed, remove the alias from the file
if [ "$1" == "--remove" ] || [ "$1" == "-r" ]
then
    sed -i "/alias $2='sudo $2'/d" ~/.bash_custom
    echo "Removed alias $2 from ~/.bash_custom"
fi

# If ~/.bash_custom is empty, remove it
if [ ! -s "~/.bash_custom" ]
then
    rm ~/.bash_custom

    # If source ~/.bash_custom is in ~/.bashrc, remove it
    if grep -q "source ~/.bash_custom" ~/.bashrc
    then
        sed -i "/source ~/.bash_custom/d" ~/.bashrc
    fi
fi

source ~/.bashrc

exit 0