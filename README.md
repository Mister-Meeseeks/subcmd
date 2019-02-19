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

## Hello World

## Companion Directory

## Directory Layout

## Help Messages

## External Tree Paths

## Install

## Dependencies
