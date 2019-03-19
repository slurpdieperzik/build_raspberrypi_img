# Build a Raspberry Pi Image Using Docker and Yocto
This repository contains the necessary information to use a docker container as a Yocto build environment to build an image for a Raspberry Pi 3. 

## Requirements
The only thing that needs installation is docker which is described in their official documents which can be found [here](https://docs.docker.com/)

## Usage
To start you need to run the _Dockerfile_ contained in this repository. Using the command line you can do this as follows: 
- `docker build /path/to/docker/directory` make sure to give the path to the directory of the Dockerfile and not the path to the Dockerfile itself. Docker should complain if you do.
*Note*: running previous command _will_ take a whil depending on your machine and internet connection. For me personally it took *_insert correct time_*. 
_continue about how to get the image from the container_ 
