## helpful

Simple app to illustrate subcmd help messages.

Let's try to the root level message:

    $ ./helpful --help
    ------ Command Help: helpful-subcmd -------

    helpful

    A nice little subcmd with some nice helpful help files.

    Root Level Commands:

    please - asks extra nice
    thank  - gratitude system

Notice this is the exact content of the help.txt contained at the root
directory

    |./helpful-subcmd/
    |--help.txt    <----- HERE

Let's try help with the thanks subcommand:

   $ ./helpful thank --help
   ------ Command Help: thank -------
   Sub-module for giving and receiving thanks
   Try it out vagrant

   Help docunmentation generated on 2019-02-19

Notice that instead of a static message, this contains dynamic content.
That's because this subcommand contains a `help` file, not a `help.txt`.
`help` files are executed, not read, to get the help message.

    |./helpful-subcmd/
    |--/thank/
    |----help     <------- HERE

`help` files are executed rather than read.

Finally let's try help with the please subcommand

    $ ./helpful please --help
    Pretty Please...

No help message was generated. That's because please is a terminal subcommand
(an exectuable file) not a composite subcommand (a directory). Therefore it
handles all of its own arguments including its help flags.

    |./helpful-subcmd/
    |--/please
