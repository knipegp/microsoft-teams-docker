FROM ubuntu:18.04

RUN apt-get update \
    # Curl
    && apt-get install -y --no-install-recommends curl=7.58.0-2ubuntu3.8 \
    && apt-get install -y --no-install-recommends ca-certificates=20180409 \
    && rm -rf /var/lib/apt/lists/*

RUN curl -LO \
    "https://teams.microsoft.com/downloads/desktopurl?env=production&plat=linux&arch=x64&download=true&linuxArchiveType=deb" \
    && mv "desktopurl?env=production&plat=linux&arch=x64&download=true&linuxArchiveType=deb" teams.deb \
	&& apt-get update \
    && apt-get install -y --no-install-recommends ./teams.deb \
	&& rm -rf /var/lib/apt/lists/* \
    && rm teams.deb

RUN apt-get remove -y curl && apt-get -y autoremove

COPY ./run_teams.sh /usr/bin/run_teams.sh

ENTRYPOINT ["run_teams.sh"]
