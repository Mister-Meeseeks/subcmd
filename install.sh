#!/bin/bash -eu

# Installs to /usr/local/bin/ by default, but if a positional argument
# is set will install to that directory.

if [[ $# -gt 0 ]] ; then
    installTgt=$1
else
    installTgt=/usr/local/bin/
fi

subcmdSrc=$(dirname $0)/subcmd

mkdir -p $installTgt
cp $subcmdSrc -t $installTgt

