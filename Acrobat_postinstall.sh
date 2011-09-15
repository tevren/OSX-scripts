#!/bin/bash
sed -i .bak 's/\&lt;string\&gt;AcroENUPro90SelfHeal\.xml\&lt;\/string\&gt;//g' /Applications/Adobe\ Acrobat\ 9\ Pro/Adobe\ Acrobat\ Pro.app/Contents/MacOS/SHInit.xml
sed -i .bak 's/\&lt;string\&gt;AcroENUDist90SelfHeal\.xml\&lt;\/string\&gt;//g' /Applications/Adobe\ Acrobat\ 9\ Pro/Acrobat\ Distiller.app/Contents/MacOS/SHInit.xml
exit 0