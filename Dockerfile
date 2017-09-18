FROM node:8-alpine
MAINTAINER Maciej Bucholc <maciek.bucholc@gmail.com>
RUN apk update
RUN apk add bash
RUN apk add openjdk8
RUN apk update && apk add jq
RUN apk add --no-cache make gcc g++ python
RUN apk add apache-ant --update-cache \
	--repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
	--allow-untrusted
RUN apk add openssh
RUN apk add git
# RUN apk add --update nodejs-current
#Drop salesforce migration tool into the ant/lib so it can be used for deployment
COPY salesforce_ant/ant-salesforce.jar /usr/share/java/apache-ant/lib/
ENV ANT_HOME /usr/share/java/apache-ant
ENV PATH $PATH:$ANT_HOME/bin
RUN node --version
RUN npm --version
RUN ant -version