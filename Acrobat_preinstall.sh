#!/bin/bash
sed -i .bak 's/\<key\>selfhealingfilename\<\/key\>/\<key\>selfhealingfilename\<\/key\>\<string\>AcroENUPro90SelfHeal\.xml\<\/string\>/g' ~/Projects/SHInit.xml
exit 0