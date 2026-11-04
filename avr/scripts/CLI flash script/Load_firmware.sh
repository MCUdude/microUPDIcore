#!/bin/bash

#################################################################################################
## Created by MCUdude for flashing mEDBG UPDI firmware onto Arduino Pro Micro boards           ##
## https://github.com/MCUdude/microUPDI                                                        ##
##                                                                                             ##
## Recommended way to flash the mEDBG firmware is through Arduino IDE. Note that this script   ##
## performs a chip erase, which also removes the bootloader of your 32U4 board. The firmware   ##
## file does not contain a bootloader, so afterwards the board can only be flashed with an ISP ##
## programmer, e.g. with this script, or by burning a bootloader again first.                  ##
##                                                                                             ##
## Execute ./Load_firmware.sh to run this script from your terminal                            ##
## Run $ chmod +x Load_firmware.sh if this script isn't executable.                            ##
##                                                                                             ##
## All you need to do is modify AVRDUDE_PATH, AVRDUDE_CONF_PATH and PROGRAMMER + EXTRA_FLAGS   ##
## fields to match your programming hardware.                                                  ##
##                                                                                             ##
#################################################################################################

# Modify these to set correct Avrdude path, programmer type and flags
AVRDUDE_PATH="/Users/hans/Library/Arduino15/packages/arduino/tools/avrdude/6.3.0-arduino18/bin/avrdude"
AVRDUDE_CONF_PATH="/Applications/Arduino.app/Contents/Java/hardware/tools/avr/etc/avrdude.conf"
PROGRAMMER="usbasp"
EXTRA_FLAGS="-Pusb"

# Target spesific
TARGET="atmega32u4"
HFUSE="0xD9"
LFUSE="0xFF"
EFUSE="0xCB"

# File spesific
FLASH_FILE="../../firmwares/mEDBG_UPDI.hex"
EEPROM_FILE="../../firmwares/mEDBG_UPDI.eep"

# Avrdude command
$AVRDUDE_PATH -C$AVRDUDE_CONF_PATH -p$TARGET -c$PROGRAMMER $EXTRA_FLAGS -e -Uhfuse:w:$HFUSE:m -Ulfuse:w:$LFUSE:m -Uefuse:w:$EFUSE:m -Ueeprom:w:$EEPROM_FILE:i -Uflash:w:$FLASH_FILE:i
