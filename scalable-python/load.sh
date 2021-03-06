#!/bin/bash
export PYTHONHOME=<BASE>
export PYTHONPATH=$PYTHONHOME/lib
export PATH=$PYTHONHOME/bin:$PATH
export MANPATH=$PYTHONHOME/share/man:$MANPATH
export LD_LIBRARY_PATH=$PYTHONHOME/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/appl/opt/libressl/2.6.4/lib:$LD_LIBRARY_PATH

if [[ $# -gt 0 ]]
then
    export PYTHONUSERBASE=$PYTHONHOME/bundle/$1
elif [[ -e $PYTHONHOME/bundle/default ]]
then
    export PYTHONUSERBASE=$PYTHONHOME/bundle/default
fi
