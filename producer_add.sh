#!/usr/bin/env bash

source ./util.sh

check_args "$@"

if [[ $PREFIXED == 0 ]]; then
    echo "role: literal producer"
    ${ACL_CMD_PREFIX} --add --allow-principal User:${USERNAME} --producer --topic ${TOPIC} > /dev/null 2>&1
else
    echo "role: prefixed producer"
    ${ACL_CMD_PREFIX} --add --allow-principal User:${USERNAME} --producer --topic ${TOPIC} --resource-pattern-type prefixed > /dev/null 2>&1
fi

[[ $? == 0 ]] && echo "status: SUCCEED" || echo "status: FAILED"
