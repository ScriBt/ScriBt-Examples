#!/bin/bash

# I want 'em colors!
NONE="\033[0m";
FLD="\033[1;31m[!]${NONE}";
SCS="\033[1;32m[!]${NONE}";
EXE="\033[1;33m[!]${NONE}";
WYT="\033[1;37m";

function derpcheck()
{
    if shellcheck --shell=bash ${OPTS} ${COMMON} "$1"; then
        echo -e "\n${SCS} ${CL_WYT}derpCheck says: $1: 404 No Derps${NONE}\n";
    else
        echo -e "\n${FLD} ${CL_WYT}derpCheck says: $1: Derped!${NONE}\n";
        DERP="yes";
    fi
} # derpcheck

# Flags to be disabled for ROM.sh
export SCOPTS_ROMsh="-e SC2154 -e SC2155 -e SC2120 -e SC2119 -e SC2086 -e SC2046 -e SC2153 -e SC2016 -e SC2030 -e SC2031";
# Flags to be disabled for upScriBt.sh - NONE, YAY
# export SCOPTS_upScriBtsh="-e SC2086";
# Flags to be disabled for src files
export SCOPTS_src="-e SC2034";
# Common Flags
export COMMON="-e SC2164 -e SC1090 -e SC1091";

# Run derpCheck
echo -e "\n${EXE} Running shellcheck on ${WYT}ROM.sh${NONE}";
OPTS="${SCOPTS_ROMsh}";
derpcheck "ROM.sh";

for file in $(find ./src -type f -path ./src/utils -prune -o -name '*.rc'); do
    # Run derpCheck on src files
    echo -e "\n${EXE} Running shellcheck on ${WYT}${file}${NONE}";
    OPTS="${SCOPTS_src}";
    derpcheck "$file";
    (( NO++ ));
done

unset SCOPTS_ROMsh SCOPTS_src SCOPTS_upScriBtsh OPTS file;

if [[ "$DERP" == "yes" ]]; then exit 1; else echo -e "\n${SCS} ScriBt is free from Derps\n"; exit 0; fi;
