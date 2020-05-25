#!/bin/bash

# Author: Fahid Nasir

# Helper script that can help copying the data from one docker volume to a new data volume.
# The script is mainly useful if you are using named volumes

# It checks the volume names provided and prompt if not provided

SOURCE_VOLUME=$1
DESTINATION_VOLUME=$2

if [ "$SOURCE_VOLUME" = "" ]; then
	echo "Please provide a source volume name"
	read SOURCE_VOLUME
fi

if [ "$DESTINATION_VOLUME" = "" ]; then
	echo "Please provide a destination volume name"
	read DESTINATION_VOLUME
fi

#Check if the source volume name does exist
docker volume inspect $SOURCE_VOLUME >/dev/null 2>&1
if [ "$?" != "0" ]; then
	echo "The source volume \"$SOURCE_VOLUME\" does not exist"
	read -p "Press any key to continue... " -n 1 -s
	exit
fi

#Now check if the destinatin volume name does not yet exist
docker volume inspect $DESTINATION_VOLUME >/dev/null 2>&1

if [ "$?" = "0" ]; then
	echo "The destination volume \"$DESTINATION_VOLUME\" already exists"
	read -p "Press any key to continue... " -n 1 -s
	exit
fi

echo "Creating destination volume \"$DESTINATION_VOLUME\"..."
docker volume create --name $DESTINATION_VOLUME
echo "Copying data from source volume \"$SOURCE_VOLUME\" to destination volume \"$DESTINATION_VOLUME\"..."
docker run --rm -it -v $SOURCE_VOLUME:/from -v $DESTINATION_VOLUME:/to busybox sh -c "cd /from ; cp -av . /to"
