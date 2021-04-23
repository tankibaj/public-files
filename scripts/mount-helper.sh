#!/usr/bin/env bash

if [ $# -ge 2 ]; then
  DEVICE_NAME=$1 #/dev/xvdh
  MOUNT_DIR=$2   #/data
  FILE_SYSTEM_TYPE=$3 #xfs
else
  echo
  echo "Usage: $0 device_name mount_dir"
  echo
  echo "Example: ./$0 /dev/xvdh /data"
  exit 1
fi

# Wait until volume get attached
VOLUME_STATE="unknown"
until [ $VOLUME_STATE = "attached" ]; do
  if lsblk | grep "$(echo "$DEVICE_NAME" | cut -d '/' -f 3)"; then
    VOLUME_STATE="attached"
  else
    sleep 5
    echo 'sleep'
  fi
done

# Format /dev/xvdh if it does not contain a partition yet
if [ "$(file -b -s "$DEVICE_NAME")" = "data" ]; then
  if [[ $FILE_SYSTEM_TYPE = "xfs" ]]; then
     mkfs.xfs "$DEVICE_NAME"
   else
     mkfs -t ext4 "$DEVICE_NAME"
   fi
fi

# Create mount directory if doesn't exist
if [[ ! -d $MOUNT_DIR ]]; then
  mkdir -p "$MOUNT_DIR"
fi

# Persist the volume in /etc/fstab so it gets mounted again
if ! df -h | grep "$MOUNT_DIR"; then
  if [[ $FILE_SYSTEM_TYPE = "xfs" ]]; then
     echo "${DEVICE_NAME} ${MOUNT_DIR} xfs defaults,nofail 0 2" >>/etc/fstab
  else
     echo "${DEVICE_NAME} ${MOUNT_DIR} ext4 defaults,nofail 0 2" >>/etc/fstab
  fi
  mount --all
fi
