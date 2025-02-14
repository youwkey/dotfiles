#!/bin/sh

echo -n "Move to trash? (y/N): "
read ans
case $ans in
  [Yy]* )
    IFS="$(printf '\n\t')"; echo mv $fx ~/.trash
    ;;
  * )
    echo "Aborted."
    ;;
esac
