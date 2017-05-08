#!/bin/sh
clear
echo "Teh ROM Builder";
echo "By Arvind7352 @XDA";
sleep 3;
#GET THOSE ROOMS
cat << _ROM_
Which ROM are you trying to build? Choose among these

CyanogenMod
AICP
AOKP
AOSP-CAF
AOSP-RRO
Tesla-M
TipsyOS
ValidusOs-M
ResurrectionRemix
PAC-ROM
TeamOrion
XOSP
DirtyUnicorns
OmniROM
_ROM_
echo "";
echo "";
read ROM_NAME;
sleep 1;
echo "";
echo "";
echo "You have chosen $ROM_NAME";
sleep 1;
echo "";
echo "Let's sync it!";
echo "";
echo "Number of Threads for Sync?";
read JOBS;
echo "";
echo "Force Sync needed? [y/n]";
read FRC;
echo "";
echo "Need some Silence in teh Terminal? [y/n]";
read SILENT;
echo "";
echo "Any Source you have already synced? If yes then specify it's location from / ";
read REF;
echo "";
#Getting Manifest Link
if [[ "$ROM_NAME" == OmniROM || "$ROM_NAME" == CyanogenMod ]]; then
	MAN=android.git;
fi
if [[ "$ROM_NAME" == TeamOrion || "$ROM_NAME" == AOSP-CAF || "$ROM_NAME" == ResurrectionRemix || "$ROM_NAME" == AOKP || "$ROM_NAME" == TipsyOS || "$ROM_NAME" == AICP || "$ROM_NAME" == XOSP-Project ]]; then
	MAN=platform_manifest.git;
fi
if [[ "$ROM_NAME" == DirtyUnicorns ]]; then
	MAN=android_manifest.git;
fi
if [[ "$ROM_NAME" == AOSP-RRO || "$ROM_NAME" == ValidusOs-M || "$ROM_NAME" == Tesla-M ]]; then
	MAN=manifest.git;
fi
if [[ "$ROM_NAME" == PAC-ROM ]]; then
	MAN=pac-rom.git;
fi
#Sync-Options
if [[ "$SILENT" == y ]]; then
  SILENT=q;
else
  SILENT= ;
fi
if [[ "$FRC" == y ]]; then
  FRC=--force-sync;
else
  FRC= ;
fi
#Naming && Syncing
echo "Name your Build Directory";
read DIR;
mkdir $DIR;
cd $DIR;
echo "Let's Initialize teh ROM Repo";
repo init --reference="$REF" -u https://github.com/"$ROM_NAME"/"$MAN" ;
echo "";
echo "Repo Init'ed";
echo "";
echo "Now Create a \"local_manifests.xml\" file and add your Device, Kernel, Vendor and other Device-Specific Sources. Press \"ENTER\" After it's Done";
read ENTER;
echo "Let's Sync!";
repo sync -j$JOBS $SILENT $FRC ;
echo "DONE!";
echo "I IZ NOOB";
echo "What's your Device's Good CodeName?";
read DEVICE;
echo "The Build type? (userdebug/user/eng)";
echo BTYP;
echo "Your Device's Company/Vendor ?";
read COMP;
echo "Now, there are Three Strategies of Adding your device to the ROM vendor so that The ROM can get built for your device. Choose the file which you find in vendor/$ROM_NAME";
echo "vendorsetup.sh (Enter 1)";
echo "$ROM_NAME.devices (Enter 2)";
echo "None of these / You see a folder named \'products\' inside teh folder (Enter 3)";
read STRT;
if [[ $STRT == 1 ]]; then
	echo "Add this line at teh end of vendorsetup.sh";
	echo "add_lunch_combo ${ROM_NAME}_${DEVICE}_${BTYP}";
fi
if [[ $STRT == 2 ]]; then
	echo "Open $ROM_NAME.devices file";
	echo "Insert this at the End of the File";
	echo "${DEVICE}";
fi
if [[ $STRT == 3 ]]; then
	echo "open the products folder";
	echo "create a file named ${DEVICE}.mk";
	echo "Add these lines";
	echo "";
	echo "";
	echo "WIP WIP!";
fi
echo "Now ${ROM_NAME}fy! your Device Tree! Press Enter when DONE ";
read NOOB;
echo "Now start the build process! The Script's work is DONE. Enjoy!";
echo "Thanks for using this script!";
sleep 1;
echo "Are you feeling even lazy to start the Build? OH COMMON! -(these commands)- . build/envsetup.sh then lunch [ROM_NAME]_${DEVICE}-${BTYP}";
echo "";
echo "I_IZ_NOOB :P";
