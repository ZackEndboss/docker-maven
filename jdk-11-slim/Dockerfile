FROM maven:slim

# ARG USER_HOME_DIR="/root"

RUN apt-get update && \
    apt-get install -y \
      gnupg gnupg2 gnupg1 \
  && rm -rf /var/lib/apt/lists/*


#ENV npmrcs "$USER_HOME_DIR/.npmrc"

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs \
  && rm -rf /var/lib/apt/lists/*


#ENV npmrcs "$USER_HOME_DIR/.npmrc"

ENTRYPOINT ["/usr/local/bin/mvn-entrypoint.sh"]
CMD ["mvn"]
