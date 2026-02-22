#!/bin/sh

case "$(file --mime-type -b "$1")" in
    image/*)          chafa --size "${2}x${3}" "$1" ;;
    application/pdf)  pdftotext "$1" - ;;
    application/zip)  unzip -l "$1" ;;
    application/gzip) tar tzf "$1" ;;
    *)                bat --style=numbers,changes,header --color=always "$1" ;;
esac
