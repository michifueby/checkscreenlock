#!/bin/bash
#Autor: MF
#Version: 1.0.2
# Check if screensaver is running or the display is locked
COUNTS=1
SCREENSAVER=1
while [ $COUNTS != "0" ] || [ $SCREENSAVER != "0" ]; do
sleep 3
COUNTTIME=$((`ioreg -c IOHIDSystem | sed -e '/HIDIdleTime/ !{ d' -e 't' -e '}' -e 's/.* = //g' -e 'q'` / 1000000000))
if [ "$COUNTTIME" -gt "200" ]; then
echo "🙁 User is away."
COUNTS=1
else 
echo "🛠 User is working!"
COUNTS=0
fi
ps ax|grep [S]creenSaverEngine > /dev/null
if [ "$?" != "0" ] ; then
echo "❌ Screensaver is disabled!"
SCREENSAVER=0
while true; do
    read -p "💻 Do enable the Screensaver (yes or no)?" yn
    case $yn in
        # Enable the Screensaver on Mac / Available from macOS High Sierra
        [Yy]* ) /System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine; break;;
        # Close it
        [Nn]* ) exit;;
        * ) echo "🖋 Please answer yes or no!";;
    esac
done
else
echo "Screensaver is enabled!"
SCREENSAVER=1
fi
done
echo "✅ Display is unlocked!"