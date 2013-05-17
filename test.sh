#!/bin/bash

fail() {
    echo 'FAIL' >&2
    echo $1 >&2
    exit 1
}

source ./kv.sh

test -f $KVFILE || fail '$KVFILE not created'

kv_set key value
test "x$( kv_get key )" == "xvalue" || fail "kv_get key should return 'value'"
kv_set key 1337
test "x$( kv_get key )" == "x1337" || fail "kv_get key should return '1337'"
kv_set another wat
test "x$( kv_get another )" == "xwat" || fail "kv_get another should return 'wat'"
kv_del another
test "x$( cat $KVFILE )" == "xkey~1337" || fail 'unexpected data in $KVFILE'

echo 'PASS'
