#!/bin/bash

for i in */;
do
  pushd ${i} >/dev/null
  if [ -f "run_tests.sh" ]
  then
    ./run_tests.sh
  fi
  popd >/dev/null
done
