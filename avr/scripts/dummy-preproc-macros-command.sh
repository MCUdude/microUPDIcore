#!/bin/bash
# A dummy executable to give the compiler recipes in platform.txt something to run. It must generate a dummy preprocessing file in order for compilation to succeed.
mkdir "$1"
touch "$1/$2"
