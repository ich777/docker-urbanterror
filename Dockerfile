FROM ich777/debian-baseimage

LABEL maintainer="admin@minenet.at"

RUN apt-get update && \
	apt-get -y install --no-install-recommends expect curl libxml2-utils libsdl2-2.0-0 && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/urbanterror"
ENV DL_URL="http://www.urbanterror.info/downloads/software/urt/43/UrbanTerror43_ded.tar.gz"
ENV GAME_V="1"
ENV DL_LOCATION="1"
ENV ENGINE="1"
ENV CHECK_FOR_UPDATES="true"
ENV GAME_PORT=27960
ENV START_PARAMS=""
ENV UMASK=0000
ENV DATA_PERM=770
ENV UID=99
ENV GID=100
ENV USER="urbanterror"

RUN mkdir $DATA_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]