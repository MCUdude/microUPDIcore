#!/bin/bash
# A wrapper script for avrdude to avoid the Arduino IDE spuriously reporting upload failures due to the expected verification error at 0x7000

readonly avrdudePath="$1"
readonly configPath="$2"
readonly buildMCU="$3"
readonly uploadProtocol="$4"
readonly serialPort="$5"
readonly uploadSpeed="$6"
readonly runtimePlatformPath="$7"

if "${avrdudePath}" "-C$configPath" -v "-p$buildMCU" "-c$uploadProtocol" "-P$serialPort" "-b$uploadSpeed" -D "-Ueeprom:w:$runtimePlatformPath/firmwares/mEDBG_UPDI_1.13.eep:i" "-Uflash:w:$runtimePlatformPath/firmwares/mEDBG_UPDI_1.13.hex:i" 2>&1 | tee /dev/stderr | grep --silent "verification error, first mismatch at byte 0x7000"; then
  # The failure was caused by the expected verification error at 0x7000 so don't report an upload error
  finalExitStatus=0
  # It's necessary to have a short delay here, otherwise the note below gets mixed in with the avrdude output in the Arduino IDE console
  sleep 0.1
  echo NOTE: The verification error shown in the output above is normal and expected.
  echo It only indicates that the DFU bootloader included in the mEDBG firmware could not be written.
  echo The standard Pro Micro bootloader was retained.
else
  finalExitStatus=${PIPESTATUS[0]}
fi

exit "$finalExitStatus"
