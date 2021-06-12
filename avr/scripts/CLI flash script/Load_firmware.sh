#!/bin/bash

#################################################################################################
## Created by MCUdude for flashing mEDBG UPDI firmware onto Arduino Pro Micro boards           ##
## https://github.com/MCUdude/microUPDI                                                        ##
##                                                                                             ##
## Recommended way to flash the mEDBG firmware is through Arduino IDE. Note that by using this ##
## script you're replacing the bootloader with Atmels DFU bootloader. This means you'll no     ##
## longer be able to upgrade the mEDBG firmware through Arduino IDE. However, you may use this ##
## script or Atmel Studio 7.                                                                   ##
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
HFUSE="0xD8"
LFUSE="0xFF"
EFUSE="0xCB"

# File spesific
FLASH_FILE="../mEDBG_UPDI_1.13_no_bootloader.hex"
EEPROM_FILE="../mEDBG_UPDI_1.13_modified_suffer.eep"

# Avrdude command
$AVRDUDE_PATH -C$AVRDUDE_CONF_PATH -p$TARGET -c$PROGRAMMER $EXTRA_FLAGS -e -Uhfuse:w:$HFUSE:m -Ulfuse:w:$LFUSE:m -Uefuse:w:$EFUSE:m -Ueeprom:w:$EEPROM_FILE -Uflash:w:$FLASH_FILE
