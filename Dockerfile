FROM crystallang/crystal:latest

RUN apt-get update && apt-get install -y \
    libssl-dev \
    libxml2-dev \
    libyaml-dev \
    libgmp-dev \
    libreadline-dev \
    libz-dev

RUN apt install crystal

ENV APP_ROOT /app
EXPOSE 8080

RUN mkdir ${APP_ROOT}
WORKDIR ${APP_ROOT}

COPY . ${APP_ROOT}
COPY shard.* ${APP_ROOT}/

CMD make run
