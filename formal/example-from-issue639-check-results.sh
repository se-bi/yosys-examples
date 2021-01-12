#!/bin/bash
return_value=0
for i in example-from-issue639-*/;
do
  pushd $i
  echo ""

  if grep -ni 'Equivalence successfully proven!' equiv.log
  then
    actual_output_string='ACTUAL:   Equivalence successfully proven!'
  else
    actual_output_string='ACTUAL:   Equivalence **__NOT__** proven!'
  fi

  echo -e $actual_output_string

  expected_output_string=`cat expected-equiv.result`
  echo -e $expected_output_string

  if [ "${actual_output_string:10:30}" != "${expected_output_string:10:30}" ]
  then
    return_value=1
  fi

  echo ""
  popd
done
exit $return_value
