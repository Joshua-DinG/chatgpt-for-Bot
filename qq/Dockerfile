FROM ubuntu:latest

# 安装必要的软件包
RUN apt-get update && apt-get install -y wget nano curl

# 下载和安装 go-cqhttp
RUN wget -O go-cqhttp.deb https://github.com/Mrs4s/go-cqhttp/releases/download/v1.0.1/go-cqhttp_1.0.1_linux_amd64.deb &>    dpkg -i go-cqhttp.deb && \
    rm -f *.deb
    
WORKDIR /app
RUN curl -f -L https://github.com/Joshua-DinG/PicGoIMG/raw/main/go-cqhttp/device.json -o ./device.json
RUN curl -f -L https://github.com/Joshua-DinG/PicGoIMG/raw/main/go-cqhttp/config.yml -o ./config.yml


CMD ["/usr/bin/go-cqhttp", "-c", "/app/config.yml"]
