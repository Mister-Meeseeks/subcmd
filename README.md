# subcmd
Create Git-style CLI sub-commands from a directory tree of executables.

subcmd allows you to combine multiple exectuables into a single sub-command structure. The
platform is language agnostic, and works with any executable type. C binaries, shell scripts,
python modules, or any mix of those or anything else.

A directory tree that looks like this:

    /app
    |--gc
    |--/run
    |----restart
    |----stop
    |----start
    
Turns into CLI commands like this:

    $ app gc
    $ app run stop
    $ app run start

## Quickstart

Clone the git repository, and step inside

    git clone https://github.com/Mister-Meeseeks/subcmd.git
    cd ./subcmd/
 
Run the install script to install to your system environment:

    sudo ./install.sh
    
Alternatively, if you're not ready to commit to a system install, just add the git repo
to your shell $PATH.

    export PATH=$PATH:$(readlink -f $0)

## Hello World

Let's create our first sub-command app. 

## Install

## Companion Directory

## Directory Layout

## Help Messages

## External Tree Paths

## Install

## Dependencies
