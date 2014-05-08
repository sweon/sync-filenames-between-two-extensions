#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 ext1 ext2" >&2
  echo "Filenames of ext2 are renamed."
  echo "Orders must match between two extensions."
  exit 1
fi

declare -a array1
i=0

for name in *.$1
do
    array1[i]=`basename "$name" .$1`
    i=$(( $i + 1 ))
done

if [ "$i" -eq 1 ]; then
  echo "Files with extension ${1} not found" >&2
  exit 1
fi

i=$(( $i - 1 ))

declare -a array2
j=0

for name in *.$2
do
    array2[j]=`basename "$name" .$2`
    j=$(( $j + 1 ))
done

if [ "$j" -eq 1 ]; then
  echo "Files with extension ${2} not found" >&2
  exit 1
fi

j=$(( $j - 1 ))

if [ "$i" -ne "$j" ]; then
  echo "The numbers of files do not match." >&2
  exit 1
fi

for (( k=0; k<=$i; k++ ))
do
    mv -v "${array2[k]}.$2" "${array1[k]}.$2"
done
