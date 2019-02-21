## Sports

A toy example to show how `env.sh` can be used to share common environments within the command tree.

The layout of the subcommand tree for this app looks like

    sports-subcmd/
    ├── env.sh
    ├── league
    │   ├── env.sh
    │   ├── evening
    │   └── weekend
    ├── relaxed
    └── youth
        ├── env.sh
        ├── popular
        └── winter
            ├── env.sh
            ├── ice
            └── warm

You'll notice that each sub-directory contains its own (non-exectuable) `env.sh` file. Each of these
files are always '.'-sourced by the bash environment before executing any subcommand underneath
that directory.

Let's take a look at the root's env.sh:

    export SPORTS_LOCATION=outside
    export SPORTS_GOAL=health
    export SPORTS_TYPE=solo
    export SPORTS_COST=cheap

    function declareAnswer() {
    ...
    }

We see a couple things here. First there's some environment variables to be used in the app. Second
it exports a (very small) library of shell functions. Those functions aren't run default, but can be 
called by from any shell-script subcommand.

Let's take a look at the top level subcommand `relax`:

    #!/bin/bash -eu

    declareAnswer tennis
    
It uses the shell function `declareAnswer` defined from the `env.sh` file. If we run it we see
that all the environment settings from `env.sh` are indeed correctly set:

    $ ./sports relaxed
    
    A good solo sport for health is tennis.
    It's usually played outside
    The cost to get started is cheap
    
Let's take a look at one of the nested `env.sh`. The `youth/env.sh` contravenes some of the 
environment exports from the root `env.sh`:

    export SPORTS_TYPE=team
    export SPORTS_GOAL="building character"
    
So, let's try one of the subcommands in this composite group:

    $ ./sports youth popular
    
    A good team sport for building character is soccer.
    It's usually played outside
    The cost to get started is cheap
 
The $SPORTS_LOCATION and $SPORTS_COST variables from the root `env.sh` are used. But it's
evident that `youth/env.sh` overrides the $SPORTS_TYPE and $SPORTS_GOAL variables. This 
shows that `env.sh` files are sourced in order from shallowest in the tree to deepest. 
Therefore any values set at one level of the tree can always be overriden inside a subtree.

To demonstrate let's take one more step down in the tree and look at `youth/winter/env.sh`:

    export SPORTS_TYPE=solo
    export SPORTS_LOCATION=inside
    
And run one of the subcommands inside this composite group:

    $ ./sports youth winter ice
    
    A good solo sport for building character is hockey.
    It's usually played inside
    The cost to get started is cheap

Let's trace back where each environment variable is coming from.

* First root `env.sh` is sourced. It sets all $SPORTS_* environment variables
* Then `youth/env.sh` is sourced. It overrides $SPORTS_TYPE and $SPORTS_GOAL
* Then `youth/winter/env.sh` is sourced. It overrides $SPORTS_TYPE from `youth/env.sh` 
and $SPORTS_LOCATION from root.
* Finally after all the env.sh settings are '.'-sourced, the subcommand at `youth/winter/ice`
is run.
