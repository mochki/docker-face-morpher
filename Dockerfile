FROM ubuntu:18.04
LABEL maintainer=""

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python2.7 \
    python-pip \
    python-tk \
    curl \
    build-essential \
    cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev \
    ffmpeg \
    imagemagick \
  # opencv
  && cd tmp && git clone https://github.com/opencv/opencv.git --depth 1 -b 3.4.0 && cd opencv \
  && mkdir release && cd release && cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local .. \
  && make && make install && cd / && rm -rf /tmp/opencv \
  && pip install \
    numpy \
    scipy \
    matplotlib \
    docopt \
    Pillow \
    future \
    opencv-python \
    facemorpher \
  # node
  && curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash \
  && source $HOME/.nvm/nvm.sh \
  && nvm install node

CMD bash