#!/bin/bash

if [ ! $# -eq 2 ]
then
    echo "Python version not specified!"
    echo "Usage: \"./travis-run-tests.sh pythonX\" with X=2/3 "
    exit 1
fi


if [ $1 == "python2" ] ; then
    test_command="nosetests"
elif [ $1 == "python3" ] ; then
    test_command="nosetests3"
fi
     
for x in $(ls test*.py */test*.py); do 
  echo
  echo
  echo "Testing $x:" 
  echo 
  if [ $x == "ensdf_processing.py" ]; then
    $test_command test_ensdf_processing.py --process-timeout=120
  else
    $test_command "$x"
  fi
  status=$?
  if [ $status -ne 0 ]; then 
    echo "Testing failed on $x" 
    exit $status
  fi
done
