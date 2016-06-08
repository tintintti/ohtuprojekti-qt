#!/usr/bin/env bash
FILES=/Users/Studies/koulu/qt-software-project/qt-projects/*
for f in $FILES
do
    cd $f
    rails c
    exit
done
