#!/usr/bin/env bash

source ./util.sh

if [[ $# < 1 ]]; then
    echo "Wrong argument number !"
    echo "Usage examples:"
    echo "1. $0 transactional-id"
    echo "   list users that can produce transactionally"
    echo "2. $0 topic test"
    echo "   list users that can operate on topic 'test'"
    echo "3. $0 topic test_*"
    echo "   list users that can operate on topics prefixed with 'test_'"
    exit 1
fi

if [[ $1 == "transactional-id" ]]; then
    ${ACL_CMD_PREFIX} --list --transactional-id "*" 2>/dev/null
elif [[ $1 == "topic" ]]; then
    parse_topic $2
    if [[ ${PREFIXED} == 1 ]]; then
        ${ACL_CMD_PREFIX} --list --topic "${TOPIC}" --resource-pattern-type prefixed 2>/dev/null
    else
        ${ACL_CMD_PREFIX} --list --topic "${TOPIC}" 2>/dev/null
    fi
else
    echo "Unsupported resource type: $1"
    exit 1
fi
