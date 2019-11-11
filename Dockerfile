FROM crystallang/crystal:latest

RUN apt-get update && apt-get install -y \
    libssl-dev \
    libxml2-dev \
    libyaml-dev \
    libgmp-dev \
    libreadline-dev \
    libz-dev \
    && rm -rf /var/lib/apt/lists/*

RUN apt install crystal

EXPOSE 4000

ENV APP_ROOT /app
WORKDIR ${APP_ROOT}

COPY . ${APP_ROOT}

RUN make build

CMD ["make", "run"]
