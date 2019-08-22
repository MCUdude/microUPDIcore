@ECHO off

::#################################################################################################::
::## Created by MCUdude for flashing mEDBG UPDI firmware onto Arduino Pro Micro boards           ##::
::## https://github.com/MCUdude/microUPDI                                                        ##::
::##                                                                                             ##::
::## Recommended way to flash the mEDBG firmware is through Arduino IDE. Note that by using this ##::
::## script you're replacing the bootloader with Atmels DFU bootloader. This means you'll no     ##::
::## longer be able to upgrade the mEDBG firmware through Arduino IDE. However, you may use this ##::
::## script or Atmel Studio 7.                                                                   ##::
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
SET HFUSE=0x99
SET LFUSE=0x1E
SET EFUSE=0xC6

:: File spesific
SET FLASH_FILE=../mEDBG_UPDI_1.13.hex
SET EEPROM_FILE=../mEDBG_UPDI_1.13.eep

@ECHO on


.\%AVRDUDE_PATH% -C%AVRDUDE_CONF_PATH% -c%PROGRAMMER% %EXTRA_FLAGS% -p%TARGET% -e -Uhfuse:w:%HFUSE%:m -Ulfuse:w:%LFUSE%:m -Uefuse:w:%EFUSE%:m -Ueeprom:w:%EEPROM_FILE% -Uflash:w:%FLASH_FILE%

PAUSE

:end