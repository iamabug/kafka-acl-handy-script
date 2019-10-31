#!/usr/bin/env bash

source ./util.sh

check_args "$@"

if [[ $PREFIXED == 0 ]]; then
    echo "role: literal transactional producer"
    ${ACL_CMD_PREFIX} --add --allow-principal User:${USERNAME} --producer --topic ${TOPIC} --transactional-id "*" > /dev/null 2>&1
else
    echo "role: prefixed transactional producer"
    ${ACL_CMD_PREFIX} --add --allow-principal User:${USERNAME} --producer --topic ${TOPIC} --resource-pattern-type prefixed --transactional-id "*" > /dev/null 2>&1
fi

[[ $? == 0 ]] && echo "status: SUCCEED" || echo "status: FAILED"
