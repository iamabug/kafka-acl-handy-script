#!/usr/bin/env bash

source ./util.sh

check_args "$@"

if [[ $PREFIXED == 0 ]]; then
    echo "role: literal consumer"
    ${ACL_CMD_PREFIX} --add --allow-principal User:${USERNAME} --consumer --topic ${TOPIC} --group "*" > /dev/null 2>&1
    [[ $? == 0 ]] && echo "status: succeed" || echo "status: FAILED"
    echo "role: literal transactional producer"
    ${ACL_CMD_PREFIX} --add --allow-principal User:${USERNAME} --producer --topic ${TOPIC} --transactional-id "*"> /dev/null 2>&1
    [[ $? == 0 ]] && echo "status: succeed" || echo "status: FAILED"
else
    echo "role: prefixed consumer"
    ${ACL_CMD_PREFIX} --add --allow-principal User:${USERNAME} --consumer --topic ${TOPIC} --group "*" --resource-pattern-type prefixed > /dev/null 2>&1
    [[ $? == 0 ]] && echo "status: succeed" || echo "status: FAILED"
    echo "role: prefixed transactional producer"
    ${ACL_CMD_PREFIX} --add --allow-principal User:${USERNAME} --producer --topic ${TOPIC} --resource-pattern-type prefixed --transactional-id "*" > /dev/null 2>&1
    [[ $? == 0 ]] && echo "status: succeed" || echo "status: FAILED"
fi
