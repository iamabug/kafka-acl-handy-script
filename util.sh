#!/usr/bin/env bash

# CHANGE THIS IF NECESSARY
# the actual path of kafka-acls.sh on your machine
# E.g., if it is already included in PATH, you can set it like this:
# ACL_SCRIPT=kafka-acls.sh
ACL_SCRIPT=/usr/hdp/3.1.4.0-315/kafka/bin/kafka-acls.sh

# Zookeeper address
# format: <ip address>:<port>,<ip address>:<port,...
ZK_ADDR=fuxi-luoge-163:2181,fuxi-luoge-164:2181


function usage() {
    echo "Usage:"
    echo "      $0 <username> <topic>"
    exit 1
}

PREFIXED=0
USERNAME=$1
TOPIC=$2

#
# check if topic is intended to be prefixed
# if yes, get the prefix
#
function parse_topic() {
    if [[ $1 == *"*" ]]; then
        PREFIXED=1
        index=0
        for ((index=0; index < ${#TOPIC}; ++index))
        do
            c=${TOPIC:index:1}
            [[ $c == "*" ]] && break;
        done
        [[ $index == 0 ]] && echo "ERROR: topic cannot start with *" && exit 1
        TOPIC=${TOPIC::$index}
    fi
}

function check_args() {
    if  [[ $# != 2 ]]; then
        echo "Wrong argument number: $# != 2"
        usage
    fi
    parse_topic $2
    echo -e "username: $USERNAME"
    echo -e "topic: $TOPIC"
}

ACL_CMD_PREFIX="${ACL_SCRIPT} --authorizer-properties zookeeper.connect=${ZK_ADDR}"
