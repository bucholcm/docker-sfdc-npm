FROM node:8-alpine
LABEL Maciej Bucholc <maciek.bucholc@gmail.com>
RUN apk update
RUN apk add bash
RUN apk add openjdk8
RUN apk add unzip
RUN apk update && apk add jq
RUN apk add --no-cache make gcc g++ python
RUN apk add apache-ant --update-cache \
	--repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
	--allow-untrusted
RUN apk add openssh
RUN apk add git

ADD https://gs0.salesforce.com/dwnld/SfdcAnt/salesforce_ant_44.0.zip /tmp/
RUN ls -lhsa /tmp
RUN unzip /tmp/salesforce_ant_44.0.zip -d /usr/share/java/apache-ant/lib/
RUN rm /tmp/salesforce_ant_44.0.zip
RUN ls -lhsa /usr/share/java/apache-ant/lib/

RUN npm install sfdx-cli --global

COPY pmd-bin-6.9.0.zip /tmp/
RUN mkdir /usr/share/pmd
RUN unzip /tmp/pmd-bin-6.9.0.zip -d /usr/share/pmd
RUN rm /tmp/pmd-bin-6.9.0.zip

COPY apex /usr/share/pmd/apex/
COPY pmd /usr/share/pmd/
RUN ls /usr/share/pmd
RUN chmod +x /usr/share/pmd/pmd

ENV ANT_HOME /usr/share/java/apache-ant
ENV PATH $PATH:$ANT_HOME/bin:/usr/local/bin/sfdx:/usr/share/pmd
RUN node --version
RUN npm --version
RUN ant -version
RUN sfdx --version