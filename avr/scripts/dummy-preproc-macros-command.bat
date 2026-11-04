@echo off
REM A dummy executable to give the preprocessor recipe in platform.txt something to run.
REM The build system expects a preprocessed file at the given output path, so the source file is simply copied there.
copy /Y "%~1" "%~2" >nul
