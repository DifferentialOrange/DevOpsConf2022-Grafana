FROM tarantool/tarantool:2.10.0-centos7

RUN yum install -y git \
                   cmake \
                   make \
                   gcc \
                   gcc-c++
COPY . .

RUN tarantoolctl rocks make app-scm-1.rockspec

CMD ["tarantool", "./init.lua"]
