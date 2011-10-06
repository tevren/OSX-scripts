#/bin/bash
ADOBEPATH="/Library/Application Support/Macromedia/mms.cfg"
MESSAGE="AutoUpdateDisable=1"
touch "$ADOBEPATH"
echo "$MESSAGE" > "$ADOBEPATH"