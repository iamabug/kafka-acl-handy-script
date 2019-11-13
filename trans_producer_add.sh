#!/usr/bin/env bash

source ./util.sh

check_args "$@"

if [[ $PREFIXED == 0 ]]; then
    echo "role: literal transactional producer"
    ${ACL_CMD_PREFIX} --add --allow-principal User:${USERNAME} --producer --topic ${TOPIC} --transactional-id "*" > /dev/null 2>&1
else
    echo "role: prefixed transactional producer"
    ${ACL_CMD_PREFIX} --add --allow-principal User:${USERNAME} --producer --topic ${TOPIC} --resource-pattern-type prefixed > /dev/null 2>&1
    [[ $? != 0]] && (echo "status: FAILED"; exit 1)
    ${ACL_CMD_PREFIX} --add --allow-principal User:${USERNAME} --transactional-id "*" > /dev/null 2>&1
fi

[[ $? == 0 ]] && echo "status: SUCCEED" || echo "status: FAILED"
