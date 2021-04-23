# Mount helper

The mount-helper script will help to do the following:

- Create mount directory
- Format file system (ext4 and xfs)
- Mount volume



#### Usage

```bash
./mount-helper device_name mount_dir file_system_type
```



#### Example ext4 

```bash
wget -O- -q https://raw.githubusercontent.com/tankibaj/public-files/main/scripts/mount-helper.sh | bash -s /dev/xvdh /data
```



#### Example xfs

```
wget -O- -q https://raw.githubusercontent.com/tankibaj/public-files/main/scripts/mount-helper.sh | bash -s /dev/xvdh /data xfs
```



## Docker demon helper

The docker-demon-helper script will help to do the following:

- Change docker default path



#### Usage

```bash
./docker-demon-helper.sh new_path_for_docker
```



#### Example

```bash
wget -O- -q https://raw.githubusercontent.com/tankibaj/public-files/main/scripts/docker-demon-helper.sh | bash -s /data/docker
```

