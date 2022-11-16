#!/usr/bin/env bash

set -e

CID_RESULTS=`pwd`/cid-results.txt
OUTPUT_DIR=`pwd`/output
CAR_FILE=builtin-actors-mainnet.car
CID_FILE=builtin-actors-mainnet.cid
echo "Test Results:" > $CID_RESULTS
COMPARE_CID=$(cat $OUTPUT_DIR/$CID_FILE)
echo "$COMPARE_CID $CID_FILE" >> $CID_RESULTS
for i in $(seq 10); do
  LOCAL_DIR=local/${i}
  DOCKER_DIR=docker/${i}
  mkdir -p $OUTPUT_DIR/$LOCAL_DIR
  mkdir -p $OUTPUT_DIR/$DOCKER_DIR


 # build binary / generate CID
 # echo Building $LOCAL_DIR/$CAR_FILE
 # BUILD_FIL_NETWORK=mainnet cargo run -- -o $OUTPUT_DIR/$LOCAL_DIR/$CAR_FILE

 echo Building $DOCKER_DIR/$CAR_FILE
 docker run --rm -it -v `pwd`:/usr/src/builtin-actors -v $OUTPUT_DIR/$DOCKER_DIR:/usr/src/builtin-actors/output filecoin/builtin-actors "make bundle-mainnet"

 # ipfs add -q $OUTPUT_DIR/$LOCAL_DIR/$CAR_FILE > $OUTPUT_DIR/$LOCAL_DIR/$CID_FILE
 ipfs add -q $OUTPUT_DIR/$DOCKER_DIR/$CAR_FILE > $OUTPUT_DIR/$DOCKER_DIR/$CID_FILE

  # compare CIDs
  for DIR in $LOCAL_DIR $DOCKER_DIR; do
    CURRENT_CID=$(cat $OUTPUT_DIR/$DIR/$CID_FILE)
    echo "$CURRENT_CID $DIR/$CAR_FILE" >> $CID_RESULTS
  done
done

echo "$(cat $CID_RESULTS)"
