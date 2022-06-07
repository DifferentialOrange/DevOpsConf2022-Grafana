FROM tarantool/tarantool:2.x-centos7

WORKDIR /app

RUN yum install -y git \
                   cmake \
                   make \
                   gcc \
                   gcc-c++
COPY . .
RUN mkdir -p tmp

# https://github.com/tarantool/cartridge-cli#installation
RUN curl -L https://tarantool.io/OtKysgx/pre-release/2/installer.sh | bash
RUN yum install -y cartridge-cli
RUN cartridge build

ENTRYPOINT cartridge start -d && \
	sleep 3 && \
	cartridge replicasets setup && \
	cartridge log -f
