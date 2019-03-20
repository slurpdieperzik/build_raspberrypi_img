# Dockerfile for using Yocto as a build environment to build an image for the Raspberry Pi 3
FROM ubuntu:18.04
MAINTAINER Bruno Horemans <bruno.horemans@qteal.com>

# upgrade system and build host packages
RUN apt-get update && apt-get -y upgrade && apt-get -y install gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
     xz-utils debianutils iputils-ping libsdl1.2-dev xterm

# set up locales                                                                 
RUN apt-get -y install locales apt-utils sudo && dpkg-reconfigure locales && locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 
ENV LANG en_US.utf8

# clean up APT when done.                                                        
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*               
                                                                                 
# replace dash with bash                                                         
RUN rm /bin/sh && ln -s bash /bin/sh                                        
                                                                                 
# user management                                                                
RUN groupadd -g 1000 build && useradd -u 1000 -g 1000 -ms /bin/bash build && usermod -a -G sudo build && usermod -a -G users build 

# run as build user from the installation path                                   
ENV YOCTO_INSTALL_PATH "/opt/yocto"                                              
RUN install -o 1000 -g 1000 -d $YOCTO_INSTALL_PATH                               
USER build                                                                       
WORKDIR ${YOCTO_INSTALL_PATH}                                                    
                                                                                 
# set the Yocto release                                                          
ENV YOCTO_RELEASE "thud"                                                         
                                                                                 
# install poky mirror                                                                  
RUN git clone --recurse-submodules https://github.com/slurpdieperzik/poky.git

# make build when container is run
CMD source /opt/yocto/poky/oe-init-build-env \
    build && bitbake core-image-base
