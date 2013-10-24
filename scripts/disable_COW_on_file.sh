#!/bin/sh

check_cow() {
  return $(lsattr $1 | sed 's/ .*//' | grep C --quiet)
}


if [[ $# -ne 1 ]] ; then
  echo "Usage: $0 <file>"
  exit 1
fi

FILE=$1

if [[ ! -f $FILE ]]; then
  echo "Sorry $FILE doesn't exists or it's a directory"
  exit 1
fi

if [[ ! -f $FILE ]]; then
  echo "Sorry $FILE doesn't exists or it's a directory"
  exit 1
fi

if $(check_cow $FILE); then
  echo "It appears that COW is already disabled for $FILE"
  exit 1
fi

SIZE=$(stat -c%s $FILE)
FILE_TMP=$1$RANDOM
FILE_TMP2=$1$RANDOM

while [[ -e $FILE_TMP || -e $FILE_TMP2 ]]; do
  FILE_TMP=$1$RANDOM
  FILE_TMP2=$1$RANDOM
done

echo "Creating temporary file $FILE_TMP and $FILE_TMP2"
if ! $(touch $FILE_TMP); then
  echo "Error while creating file, exiting"
  exit 1
fi
if ! $(touch $FILE_TMP2); then
  echo "Error while creating file, exiting"
  rm -f $FILE_TMP
  exit 1
fi

echo "Setting C flag (COW disable) on $FILE_TMP"
if ! $(chattr +C $FILE_TMP) ; then
  echo "Error while setting COW, exiting"
  rm -f $FILE_TMP $FILE_TMP2
  exit 1
fi
if ! $(check_cow $FILE_TMP) ; then
  echo "Strange.. the COW was not set. Exiting."
  rm -f $FILE_TMP $FILE_TMP2
  exit 1
fi

echo "Allocating $SIZE bytes..."
if ! $(fallocate -l$SIZE $FILE_TMP); then
  echo "Error while allocating, exiting"
  rm -f $FILE_TMP $FILE_TMP2
  exit 1
fi

echo "Now copying $FILE to ${FILE_TMP}. This may take a while..."
echo
if ! $(dd if=$FILE of=$FILE_TMP bs=10M); then
  echo "Error while copying! Exiting"
  rm -f $FILE_TMP $FILE_TMP2
  exit 1
fi
echo

echo "Renaming $FILE to $FILE_TMP2"
if ! $(mv $FILE $FILE_TMP2); then
  echo "Error while moving, please check the consistency of files. Exiting now!"
  exit 1
fi

echo "Final stage: renaming $FILE_TMP to $FILE"
if ! $(mv $FILE_TMP $FILE); then
  echo "Error while moving, please check the consistency of files. Exiting now!"
  exit 1
fi

echo "Operation terminated. Old file is: $FILE_TMP2, you may want to delete it!"
