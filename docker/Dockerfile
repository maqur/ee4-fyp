FROM ubuntu:16.04

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y apt-utils --no-install-recommends
RUN apt-get install -y vim git tmux htop wget unzip openjdk-8-jre-headless texlive-latex-base --no-install-recommends

WORKDIR /tmp
RUN wget https://tla.msr-inria.inria.fr/tlatoolbox/dist/tla.zip

WORKDIR /opt
RUN unzip /tmp/tla.zip

ENV CLASSPATH=/opt/tla

RUN echo "#!/bin/sh \n java tlc2.TLC \$@ " > /usr/local/bin/tlc
RUN echo "#!/bin/sh \n java tl2sany.SANY \$@ " > /usr/local/bin/sany
RUN echo "#!/bin/sh \n java pcal.trans \$@ " > /usr/local/bin/pcal
RUN echo "#!/bin/sh \n java tla2tex.TLA \$@ " > /usr/local/bin/tla2tex

RUN chmod +x /usr/local/bin/*

RUN mkdir /home/user

WORKDIR /home/user

