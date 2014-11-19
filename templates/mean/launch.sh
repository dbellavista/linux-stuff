#!/bin/bash

DEFAULT_ENV='developement'

if [[ -z "$NODE_ENV" ]] ; then
  echo " [*] Warning node env not set, falling back in $DEFAULT_ENV"
  export NODE_ENV=$DEFAULT_ENV
fi

case "$NODE_ENV" in
  'developement')
    echo " [$NODE_ENV >] nodemon app.js"
    nodemon app.js
    ;;
  'production' | 'testing')
    echo " [$NODE_ENV >]  node app.js"
    node app.js
    ;;
  *)
    echo " [*] ERROR: node_env \"$NODE_ENV\" not recognized!"
esac
