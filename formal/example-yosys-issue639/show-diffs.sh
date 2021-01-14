#!/bin/bash

for i in */;
do
  echo -e "\n$i\n"
  pushd $i
  diff old.v new.v
  echo -e "\n\n"
  popd
done
