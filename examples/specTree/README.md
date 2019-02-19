
This example directory contains several different executable entrypoints, which
each serves to show a different way that the companion command tree can be
specified.

To start the `srvctl` file contains:

    #!/usr/bin/env subcmd

    ./serverCmds/

The last line is a command tree spec, and contains a path relative to the entry
point. In this case it's the `serverCmds/` directory found in this example dir.

A relative path doesn't need to be in the same directory as its companion
directory. This can be seen with the `./tools/remote` entryPoint which imports the
same `serverCmds` command tree:

    #!/usr/bin/env subcmd

    ../serverCmds

(Yes, multiple entrypoints can share the same command tree directory)

An example of how to use an absolute path as a tree spec is the `sysbins` entry
point:

    #!/usr/bin/env subcmd

    /bin/

Finally there's no firm requirement that the command directory always starts
at the same root. The `webctl` entrypoint shows us how we can root our command
tree within the sub-directory of another command tree:

    #!/usr/bin/env subcmd

    serverCmds/web/

That's a cool trick because it makes `webctl` equivalent to running the
subcommand `srvctl web`. For example these two commands are identical

    $ ./srvctl web start
    $ ./webctl start
