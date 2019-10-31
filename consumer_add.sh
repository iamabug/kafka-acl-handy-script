#!/usr/bin/env bash

source ./util.sh

check_args "$@"

if [[ $PREFIXED == 0 ]]; then
    echo "role: literal consumer"
    ${ACL_CMD_PREFIX} --add --allow-principal User:${USERNAME} --consumer --topic ${TOPIC} --group "*" > /dev/null 2>&1
else
    echo "role: prefixed consumer"
    ${ACL_CMD_PREFIX} --add --allow-principal User:${USERNAME} --consumer --topic ${TOPIC} --group "*" --resource-pattern-type prefixed > /dev/null 2>&1
fi

[[ $? == 0 ]] && echo "status: SUCCEED" || echo "status: FAILED"
