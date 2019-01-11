#!/bin/bash

filename="$1"
basename=${filename%".gv"}
ps2name="$basename"".ps2"
pdfname="$basename"".pdf"

dot -Tps2 -o "$ps2name" "$filename"
if [ -f "$ps2name" ]; then
    ps2pdf -sOutputFile="$pdfname" "$ps2name"
    rm "$ps2name"
fi
