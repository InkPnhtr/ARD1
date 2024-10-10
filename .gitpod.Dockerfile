FROM ubuntu:20.04

# Set the timezone environment variable
ENV TZ=Europe/London

# Link the timezone file and install tzdata non-interactively
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y sudo xvfb tzdata git unzip patch libncurses5-dev libncursesw5-dev libgtk2.0-dev libxml2-dev libudev-dev libiw-dev libsdl1.2-dev lib32z1 build-essential daemontools net-tools nano gcc-multilib &&\
    echo "ALL ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers



# ADD ARDrone_SDK_2_0_1.zip patches/ardrone1404.patch patches/ardrone1604.patch patches/OSXSegFault.patch /root/

RUN if [ ! `grep "precise" /etc/lsb-release` ]; then dpkg --add-architecture i386; fi  && \
	apt-get -qq update && \
	apt-get -qq install -y unzip patch libncurses5-dev libncursesw5-dev libgtk2.0-dev libxml2-dev libudev-dev libiw-dev libsdl1.2-dev lib32z1 build-essential daemontools net-tools nano gcc-multilib && \ 
	export DEBIAN_FRONTEND=teletype 

# Clean up to reduce the image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Start Xvfb when the container starts
CMD Xvfb :99 -screen 0 1024x768x16 & \
    export DISPLAY=:99 && \
    tail -f /dev/null


# RUN	ls "/files/ARDrone_SDK_2_0_1" || unzip -d /files/ /root/ARDrone_SDK_2_0_1.zip && \
#    	cd /files/ && \ 
#     	patch -p2  < /root/ardrone1404.patch && \
#     	patch -p2  < /root/ardrone1604.patch && \
# 	rm -rf /root/ARDrone_SDK_2_0_1.zip /files/__MACOSX /files/.DSStore && \
# 	find . -name '.DS_Store' -type f -delete && \
# 	rm -rf /var/lib/apt/lists/* && \
# 	cd /files/ARDrone_SDK_2_0_1/Examples/Linux && \
# 	make

# 	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

# 	InkPnhtr
	