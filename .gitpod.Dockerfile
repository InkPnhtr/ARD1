FROM ubuntu:20.04

ENV TZ=Europe/London

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y sudo xvfb tzdata git unzip patch libncurses5-dev libncursesw5-dev \
    libgtk2.0-dev libxml2-dev libudev-dev libiw-dev libsdl1.2-dev lib32z1 build-essential daemontools net-tools nano gcc-multilib \
    locales && \
    locale-gen en_US.UTF-8

ADD files/ARDrone_SDK_2_0_1.zip patches/ardrone1404.patch patches/ardrone1604.patch /root/

RUN unzip -d /files/ /root/ARDrone_SDK_2_0_1.zip && \
    cd /files/ && \
    patch -p2 < /root/ardrone1404.patch && \
    patch -p2 < /root/ardrone1604.patch && \
    make -C /files/ARDrone_SDK_2_0_1/Examples/Linux

# Start Xvfb
CMD Xvfb :99 -screen 0 1024x768x16 & \
    export DISPLAY=:99 && \
    tail -f /dev/null
