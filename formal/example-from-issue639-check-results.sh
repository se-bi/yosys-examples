#!/bin/bash

for i in example-from-issue639-*/;
do
  pushd $i
  echo ""
  if grep -ni 'Equivalence successfully proven!' equiv.log
  then
    echo -e "\nACTUAL:   Equivalence successfully proven!"
  else
    echo -e "\nACTUAL:   Equivalence **__NOT__** proven!"
  fi
  cat expected-equiv.result
  echo ""
  popd
done
