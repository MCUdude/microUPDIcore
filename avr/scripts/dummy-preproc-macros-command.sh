#!/bin/bash
# A dummy executable to give the preprocessor recipe in platform.txt something to run.
# The build system expects a preprocessed file at the given output path, so the source file is simply copied there.
mkdir -p "$(dirname "$2")"
cp "$1" "$2"
