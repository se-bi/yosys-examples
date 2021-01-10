#!/bin/bash

for i in example-from-issue639-*/
do
  pushd $i
  yosys equiv_check.ys | tee equiv.log
  popd
done
