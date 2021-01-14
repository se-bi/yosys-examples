#!/bin/bash

for i in */
do
  pushd $i
  yosys equiv_check.ys | tee equiv.log
  popd
done
