#!/bin/bash

# I want 'em colors!
NONE="\033[0m";
FLD="\033[1;31m[!]${NONE}";
SCS="\033[1;32m[!]${NONE}";
EXE="\033[1;33m[!]${NONE}";
WYT="\033[1;37m";

function derpcheck()
{
    if [[ "$?" == "0" ]]; then
        echo -e "\n${SCS} ${CL_WYT}derpCheck says: $1: 404 No Derps${NONE}\n";
    else
        echo -e "\n${FLD} ${CL_WYT}derpCheck says: $1: Derped!${NONE}\n";
        DERP="yes";
    fi
} # derpcheck

# Flags to be disabled for ROM.sh
export SCOPTS_ROMsh="-e SC2154 -e SC2155 -e SC2120 -e SC2119 -e SC2086 -e SC2046 -e SC2153 -e SC2016 -e SC2030 -e SC2031";
# Flags to be disabled on ROM.rc
export SCOPTS_ROMrc="-e SC2034 -e SC2153 -e SC2154";
# Flags to be disabled on upScriBt.sh
export SCOPTS_upScriBtsh="-e SC2086";
# Common Flags
export COMMON="-e SC2164 -e SC1090";

NO=1;
echo;
for file in ROM.sh ROM.rc upScriBt.sh; do
    # Run derpCheck
    echo -e "${EXE} ${CL_WYT}Running shellcheck on $file${NONE}";
    OPTS="-e $(eval echo -e "\${SCOPTS_${file/\./}}")";
    shellcheck --shell=bash ${OPTS} ${COMMON} "$file";
    derpcheck "$file";
    (( NO++ ));
done

unset SCOPTS_ROMsh SCOPTS_ROMrc SCOPTS_upScriBtsh OPTS NO file;

if [[ "$DERP" == "yes" ]]; then exit 1; fi;
