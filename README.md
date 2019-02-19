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

Let's create our first sub-command app. Initialize a new subcmd tree from the command line with

    subcmd init hello
    
You should see something like:

    New subcmd tree initialized.
    
    To create sub-commands add executables to the cmdTree:
    ./hello-subCmd/
    
    Command can be invoked by calling the entrypoint at: 
    ./hello

Now let's try out our new sub-command. We list out what sub-commands are available with the
`CMD` directive. From the shell:

    ./hello CMD
    
You'll see we don't have anything in the subcommand tree.

    ------- Valid Sub-Commands for hello-subcmd -----

    --------------------------------------------

Let's create a subcommand. Create an exectuable inside the subcommand tree. From the shell:

    touch hello-subcmd/world && chmod u+x hello-subcmd/world
    
Now in your favorite editor open the new file at `hello-subcmd/world`, and add the following

    #!/bin/bash
    
    echo "Hello, World!"

Now, let's check our entry point, from the command line:

    $ ./hello CMD
    subcmd Error: /home/vagrant/sith/subcmd/work/hello-subcmd// is a directory
    ------ Valid Sub-Commands for hello-subcmd -----
    
    world
    
   --------------------------------------------

Alright! Now let's try the subcommand that. From the command line:

    $ ./hello world
    Hello, World!
   
There we go. Our first subcmd app.

## Install

To install in a standard Linux system environment, call the install script included in the repo.

    sudo ./install.sh
    
By default the program is installed at `/usr/local/bin/`. But if you pass an argument to the
install script, you can install at any custom location. For example if you don't have sudo access
and want to install in $HOME:

    ./install.sh ~/local/bin/
    
Finally the subcmd runs in a single script. You can bypass git and download the script directly
to your system environmnet. This works well in minimal environments:

    sudo curl https://raw.githubusercontent.com/Mister-Meeseeks/subcmd/master/subcmd /usr/local/bin/ \
      && chmod u+x /usr/local/bin/subcmd
      
Or in a Dockerfile add the layer:

    RUN sudo curl https://raw.githubusercontent.com/Mister-Meeseeks/subcmd/master/subcmd /usr/local/bin/ \
      && chmod u+x /usr/local/bin/subcmd

## Companion Directory

## Directory Layout

## Help Messages

## External Tree Paths

## Install

## Dependencies
