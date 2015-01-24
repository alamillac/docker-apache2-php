#!/bin/bash

rm -f /var/run/apache2/apache2.pid

DIR_APP="/opt/app"

[ -d "$DIR_APP" ] && rm -rf "$DIR_APP"

if [ -n "$WGET_ZIP_APP" ]
then
    cd /tmp/ &&
    wget --no-check-certificate "$WGET_ZIP_APP" -O temp.zip &&
    unzip -o temp.zip -d "$DIR_APP" &&
    rm temp.zip
else
    [ -n "$GIT_APP" ] && git clone "$GIT_APP" "$DIR_APP" || { cd "$DIR_APP" && git pull ; }
fi

[ $? -eq 0 ] || exit 1

supervisord &&
supervisorctl tail -f apache2
