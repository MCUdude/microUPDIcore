@echo off
REM A wrapper script for avrdude to prevent spurious upload errors caused by the expected verification error at 0x7000

REM Allow error level to be accessed via !ERRORLEVEL! in command blocks
setlocal ENABLEDELAYEDEXPANSION

REM Give nice names to the command line arguments and strip the wrapping quotes
set avrdudePath=%~1
set configPath=%~2
set buildMCU=%~3
set uploadProtocol=%~4
set serialPort=%~5
set uploadSpeed=%~6
set runtimePlatformPath=%~7
set buildPath=%~8

REM Run the avrdude command and redirect all output to a text file (necessary in order to both display the output on the console and run findstr on it)
"%avrdudePath%" "-C%configPath%" -v -p%buildMCU% -c%uploadProtocol% "-P%serialPort%" -b%uploadSpeed% -D "-Ueeprom:w:%runtimePlatformPath%/firmwares/mEDBG_UPDI_1.13_modified_suffer.eep:i" "-Uflash:w:%runtimePlatformPath%/firmwares/mEDBG_UPDI_1.13.hex:i"> "%buildPath%/avrdudeoutput.txt" 2>&1

set finalExitStatus=%errorlevel%

REM Display the avrdude output on the console
type "%buildPath%\avrdudeoutput.txt"

if NOT %finalExitStatus% == 0 (
  REM Check if the failure was caused by the expected verification error at 0x7000
  findstr /c:"verification error, first mismatch at byte 0x7000" "%buildPath%\avrdudeoutput.txt" >nul 2>&1
  if !ERRORLEVEL! == 0 (
    REM The failure was caused by the expected verification error at 0x7000 so don't report an upload error
    set finalExitStatus=0
    echo NOTE: The verification error shown in the output above is normal and expected.
    echo It only indicates that the DFU bootloader included in the mEDBG firmware could not be written.
    echo The standard Pro Micro bootloader was retained.
  )
)

exit /b %finalExitStatus%
