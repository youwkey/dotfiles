#!/bin/sh

printf "Move to trash? (y/N): "
read ans
case $ans in
  [Yy]* )
    IFS="$(printf '\n\t')"; trash $fx
    ;;
  * )
    echo "Aborted."
    ;;
esac
