FROM maven:latest

RUN apt-get update && \
    apt-get install -y \
      gnupg gnupg2 gnupg1 \
  && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs \
  && rm -rf /var/lib/apt/lists/*
  
