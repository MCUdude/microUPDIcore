@echo off
REM A dummy executable to give the compiler recipes in platform.txt something to run. It must generate a dummy preprocessing file in order for compilation to succeed.
echo > "%1/%2"
