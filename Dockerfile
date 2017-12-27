FROM debian:stable-20171210

RUN apt-get update && apt-get install -y curl wget gnupg2 build-essential rtorrent git procps
RUN curl -sL https://deb.nodesource.com/setup_8.x |  bash
RUN apt-get update && apt-get install -y nodejs


RUN mkdir /rtorrent && mkdir /rtorrent/log /rtorrent/.session /rtorrent/flood && cd /rtorrent/log && touch rtorrent.log tracker.log storage.log
COPY rtorrent.rc /root/.rtorrent.rc

RUN git clone https://github.com/jfurrow/flood.git

COPY flood.config.js /flood/config.js
RUN cd flood && npm install && npm run build

VOLUME ["/rtorrent/log","/rtorrent/.session"]

CMD touch /rtorrent/.session/rtorrent.lock && rm /rtorrent/.session/rtorrent.lock && cd flood && npm start > /dev/null & rtorrent
