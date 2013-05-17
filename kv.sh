#!/bin/bash

KVFILE=$( mktemp )

kv_get() {
    grep $1 $KVFILE | cut -d'~' -f2-
}

kv_set() {
    if [ "x$( kv_get $1 )" == "x" ]; then
        echo "$1~$2" >> $KVFILE
    else
        sed -i "s/^$1~.*$/$1~$2/g" $KVFILE
    fi
}

kv_del() {
    sed -i "/^$1~.*$/d" $KVFILE
}
