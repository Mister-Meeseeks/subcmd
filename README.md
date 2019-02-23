# subcmd
Create Git-style CLI sub-commands from a directory tree of executables.

subcmd allows you to combine multiple exectuables into a single sub-command structure. The
platform is language agnostic, and works with any executable type. C binaries, shell scripts,
python modules, or any mix of those or anything else.

A directory tree like this:

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

    export PATH=$PATH:$(readlink -f .)

## Hello World

Let's create our first sub-command app. Initialize a new subcmd tree from the command line with

    $ subcmd init hello
    
    New subcmd tree initialized.
    
    To create sub-commands add executables to the cmdTree:
    ./hello-subCmd/
    
    Command can be invoked by calling the entrypoint at: 
    ./hello

Now let's try out our new sub-command. We list out what sub-commands are available with the
`CMD` directive. And see an empty tree. From the shell:

    $ ./hello CMD
    ------- Valid Sub-Commands for hello-subcmd -----
  
Let's make a subcommand. Create an exectuable inside the subcommand tree. From the shell:

    touch hello-subcmd/world && chmod u+x hello-subcmd/world
    
Now in your favorite editor create the following file with content:

*./hello-subcmd/world*

    #!/bin/bash
    echo "Hello, World!"

Now, let's check our entry point, from the command line:

    $ ./hello CMD
    ------ Valid Sub-Commands for hello-subcmd -----
    world

Alright! Now let's try running the new subcommand.

    $ ./hello world
    Hello, World!

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

## subcmd init

To create a new subcommand app, invoke from the command line

    subcmd init [path]

Where `[path]` is the filesystem path, where you want the app's entrypoint exectuable to live. Preferably
some directory inside your environment's $PATH. By default that creates a companion command tree directory
at `[path]-subcmd/`. From that directory you can layout your subcommand structure.

You can also specify an alternative location for the companion command tree by invoking with:

    subcmd init [path] [cmdTree directory path]

## Command Tree Directory

The command tree is just a normal filesystem directory. Any sub-directory is a composite of subcommand based
on that directory's contents. Any executable file in a terminal subcommand. Subcommands can be arbitrarily
nested. For example, say `pop` is an exectuable inside the command tree at the following path:

    [cmdTree root]/snap/crackle/pop
    
Pop is a terminal subcommand of crackle. Crackle is a composite subcommand of snap. Snap is a top-level 
subcommand of the app. To call the `pop` command from the subcommand we'd invoke the following at the command 
line.

    $ [appCmd] snap crackle pop
    
Some other details:
  * The command tree follows all symbolic both for directories and files. 
  * The subcommand name is based on the symbolic link's name, not the name of its target.
  * Non-exectuable files are ignored.
  * Directory or filenames with whitespace or quotes is not supported.

## env.sh

subcmd provides a hook for consolidating a common environment. It can be set either for the entire command 
tree, or a specific subtree. Or both. Just add a non-exectuable bash-compatible source file named `env.sh`
at any directory in the command tree. If present a subcmd call will '.'-source into the shell environment
before executing any terminal command underneath that directory.

`env.sh` can be added at the root of the command tree and will apply across the entire subcommand app.
Or it can be added inside a composite subcommand and will apply across all child subcommands. Multiple
`env.sh` in the call will be added starting at the root and ending at the node. E.g. the follwing command

    $ myApp snap crackle pop

Will '.'-source in this order,

* `[cmdTree root]/env.sh` (if exists)
* `[cmdTree root]/snap/env.sh` (if exists)
* `[cmdTree root]/snap/crackle/env.sh` (if exists)

One typical use for `env.sh` is to set environment variables. Another is to define and export shell 
functions to act as a shared library between all the subcommand scripts. But any bash compatible
code can be used to run before the exectuable. Things like creating temporary files, setting signal
handlers, printing startup messages, etc.

## CMD List

submcd allows for the CMD keyword directive to be added to any composite subcommand in a command tree.
Instead of normal processing, it will list all available commands contained by that subcommand. This 
can be used to probe the command tree structure from the command line. E.g.

    $ [appCmd] snap crackle CMD
    
    ------ Valid Sub-Commands for hello-subcmd -----
    pop

## Help Messages

subcmd gives special consideration to files in the command tree named `help.txt` or `help`. To print out
a help message for a composite subcommand call with --help command:

    $ [appCmd] snap crackle --help

That will look for one of two files:

    [cmdTree root]/snap/crackle/help.txt
    [cmdTree root]/snap/crackle/help

If `help.txt` exists, subcmd will print out its contents to STDERR and exit. If `help` exists, subcmd
will try to run it as an executable and print its output to STDERR, then exit.

Please note that help files are specific to their sub-directory and subcommand. I.e.

    $ [appCmd] snap --help

will look for `snap/help.txt` and give up if it doesn't exist. Regardless of the existence or contents
of any other help files in the command tree.

Also note that for terminal commands (i.e. executable leaves in the directory tree), help flags are
passed straight through to the executable and not handled by subcmd. 

## Entrypoints

subcommand requires an entrypoint exectuable to the command tree. This is created automatically by
subcmd init. But it's simple to create your own. The simplest use is just to create an empty exectuble
script with the shebang line set to subcmd:

    #!/usr/bin/env subcmd
    
Nothing else is needed. By default it will look for a companion directory with the same name as the
entrypoint but with `-subcmd` postfix. E.g.

    ./bin/myApp
    ./bin/myApp-subcmd/

Alternatively an entrypoint can contain one non empty, non-commented line. The value of that line
is the path to the companion command tree directory. The path can be either relative or absolute,
but if its relative, it's always relative to the entrypoint's directory. *Not* the the invoker's
working directory. 

Let's say we wanted an exectuable entry point at

    ./bin/myApp
    
And we want a command tree at

    ./src/scripts/myCmds
    
Then we can easily set that inside the entrypoint (`./bin/myApp`0 by setting its content to

    #!/usr/bin/env subcmd
    
    ../src/scripts/myCmds/

Another useful mechanism is to install a system environment binary that references an external
command tree. We can create a system-level command called `myApp` that references a locally
created command tree. Just create an exectuable at `/usr/bin/myApp` and set its contents to

    #!/usr/bin/env subcmd
    
    /home/jsmith/myApp/scripts/cmds/
    
## Dependencies

* bash
* Linux-style readlink (sorry BSD and MacOS)
