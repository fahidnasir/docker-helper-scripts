# 1. Docker Helper Scripts <!-- omit in toc -->

- [1.1. Pre-Requisites](#11-pre-requisites)
- [1.2. List of Scripts](#12-list-of-scripts)
  - [1.2.1. `docker_volume_clone.sh`](#121-docker_volume_clonesh)
    - [1.2.1.1. Parameters](#1211-parameters)
    - [1.2.1.2. Use Case](#1212-use-case)
    - [1.2.1.3. How it works](#1213-how-it-works)
  - [1.2.2. `docker_volume_get_info.sh`](#122-docker_volume_get_infosh)
    - [1.2.2.1. Use Case](#1221-use-case)
    - [1.2.2.2. How it works](#1222-how-it-works)

**_This repository contains shell scripts for docker to automate/help routine operations._**

## 1.1. Pre-Requisites

1. Make the shell files executable
   - Navigate to the folder
   - Run the command: `chmod +x *.sh`

## 1.2. List of Scripts

### 1.2.1. `docker_volume_clone.sh`

This will create a new destination volume and copy all the files from source to this new destination volume.

```sh
./docker_volume_clone.sh name_or_id_of_source_volume destination_volume_name
```

#### 1.2.1.1. Parameters

You can provide the following parameters as command line params or script will ask you to provide the value.

1. `SOURCE VOLUME`
2. `DESTINATION VOLUME`

#### 1.2.1.2. Use Case

Before releasing a new version, copy all the files from the older volume to a new volume to attach it with the latest version.

#### 1.2.1.3. How it works

1. Check if parameters are provided
2. Prompt for the missing parameter value(s)
3. Check availability of Source volume (fails if doesn't exist)
4. Check availability of Destination volume (fails if already exist)
5. Create a data container from an official [busybox](https://hub.docker.com/_/busybox) image
   1. Mount both Source and Destination volumes into the container
   2. Run the `copy command` inside the data container to copy everything from source container to destination container.

### 1.2.2. `docker_volume_get_info.sh`

This script will list all the volumes with the attached stopped or running container IDs and disk space size.

```sh
./docker_volume_get_info.sh
```

#### 1.2.2.1. Use Case

Docker doesn't provide an API to get size of docker volume.
So instead of running multiple commands, Conveniently get all available volume(s) information by running this single script.

#### 1.2.2.2. How it works

This script use [busybox](https://hub.docker.com/_/busybox) to mount volume and calculate the size of folder inside the volume using [du](http://www.linfo.org/du.html) library.
