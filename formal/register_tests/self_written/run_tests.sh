#!/bin/bash

echo "----------------------------------------------------------------------------"
echo "Start test cases comparing self writte register file implementations"
echo "----------------------------------------------------------------------------"
i=1
for d in */ ; do
    pushd $d  >/dev/null
    sh run_yosys.sh  >/dev/null
    if grep -q 'Equivalence successfully proven!' equiv.log;
    then
        echo -e '\n'
        echo "Test $d was successful!"
    else
        echo -e '\n'
        echo "Test $d FAILED!"
    fi
    if grep -qi 'error' equiv.log;
    then
        echo "There is an ERROR in test run $d"
    fi
    popd  >/dev/null
done
