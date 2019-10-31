# kafka-acl-handy-script
Handy script for managing Kafka ACLs

#Introduction

Scripts in this repo are simply wrappers of `kafka-acls.sh`.

Scripts and their functions are shown below.

|        script         |                  function                   |
| :-------------------: | :-----------------------------------------: |
|    consumer_add.sh    |              add new consumer               |
|    producer_add.sh    |              add new producer               |
| trans_producer_add.sh |       add new transactional producer        |
|      add_both.sh      |        add new consumer and producer        |
|   whole_pack_add.sh   | add new consumer and transactional producer |
| list_for_resources.sh |      list ACLs for specified resources      |

I feel that I should make some improvements about the script names but this is the best I can do because I want them to start with different characters so that Tab can work smoothly. Comments are appreciated.

# Usage

Modify `util.sh` before anything. There are two variables to be modified.

```bash
# change ACL_SCRIPT to the path of kafka-acls.sh existing on your machine
ACL_SCRIPT=/usr/hdp/3.1.4.0-315/kafka/bin/kafka-acls.sh

# change ZK_ADDR to actual Zookeeper addresses
ZK_ADDR=ZK1:2181,ZK2:2181
```

All scripts except the last one accept two arguments: username and topic. 

Example usages:

1. add user 'alice' as a consumer of topic 'topic1'

   ```bash
   ./consumer_add.sh alice topic1
   ```

2. add user 'bob' as a transactional producer of topic 'topic2'

   ```bash
   ./trans_producer_add.sh bob topic2
   ```

3. add user 'eva' as a consumer and producer of topics prefixed with 'topic3_'

   ```bash
   ./whole_pack_add.sh eva topic3_*
   # note that an asterisk is used to indicate prefixed topics
   # CAUTION: use quotes when topics have the same prefixes with these script names to avoid path expansion
   # UNEXPCTED:
   # ./whole_pack_add.sh eva add_*
   # the right way
   # ./whole_pack_add.sh eva "add_*"
   ```

4. `list_for_resources.sh` script should be used like this:

   ```bash
   ./list_for_resources.sh transactional-id
   # list all ACLs about transcational IDs
   ./list_for_resources.sh topic test
   # list ACLs that involve 'test'
   ./list_for_resources.sh topic test_*
   # list ACLs that involve topics prefixed with 'test_'
   ```

   

