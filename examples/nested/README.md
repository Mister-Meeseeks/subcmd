
## sounds

This example shows how the nested directory structure is mirrored
in the subcommand tree.

First let's take a look at the command tree directory:

    $ tree ./sounds-subcmd/
    
    ./sounds-subcmd/
    ├── animals
    │   ├── fish
    │   └── mammals
    │       ├── felines
    │       │   ├── housecat
    │       │   └── lion
    │       └── horse
    └── vehicles
        ├── car
	└── plane

To call the plane subcommand we'd use

    $ ./sounds vehicles plane

To call the fish subcommand we'd use

    $ ./sounds animals fish

To call the horse we use

    $ ./sounds animals mammals horse

To call the lion we use

    $ ./sounds animals mammals felines lion
