@ECHO off

::#################################################################################################::
::## Created by MCUdude for flashing mEDBG UPDI firmware onto Arduino Pro Micro boards           ##::
::## https://github.com/MCUdude/microUPDI                                                        ##::
::##                                                                                             ##::
::## Recommended way to flash the mEDBG firmware is through Arduino IDE. Note that this script   ##::
::## performs a chip erase, which also removes the bootloader of your 32U4 board. The firmware   ##::
::## file does not contain a bootloader, so afterwards the board can only be flashed with an ISP ##::
::## programmer, e.g. with this script, or by burning a bootloader again first.                  ##::
::##                                                                                             ##::
::## All you need to do is modify AVRDUDE_PATH, AVRDUDE_CONF_PATH and PROGRAMMER + EXTRA_FLAGS   ##::
::## fields to match your programming hardware.                                                  ##::
::##                                                                                             ##::
::#################################################################################################::

:: Modify these fields to set correct Avrdude path, config path, programmer type and flags
SET AVRDUDE_PATH=/path/to/avrdude.exe
SET AVRDUDE_CONF_PATH=/path/to/avrdude.conf
SET PROGRAMMER=usbasp
SET EXTRA_FLAGS=-Pusb

:: Target spesific
SET TARGET=atmega32u4
SET HFUSE=0xD9
SET LFUSE=0xFF
SET EFUSE=0xCB

:: File spesific
SET FLASH_FILE=../../firmwares/mEDBG_UPDI.hex
SET EEPROM_FILE=../../firmwares/mEDBG_UPDI.eep

@ECHO on


.\%AVRDUDE_PATH% -C%AVRDUDE_CONF_PATH% -c%PROGRAMMER% %EXTRA_FLAGS% -p%TARGET% -e -Uhfuse:w:%HFUSE%:m -Ulfuse:w:%LFUSE%:m -Uefuse:w:%EFUSE%:m -Ueeprom:w:%EEPROM_FILE%:i -Uflash:w:%FLASH_FILE%:i

PAUSE

:end
