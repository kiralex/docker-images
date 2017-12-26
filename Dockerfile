FROM debian:stable-20171210

RUN apt-get update && apt-get install -y curl wget gnupg2 build-essential rtorrent git 
RUN curl -sL https://deb.nodesource.com/setup_8.x |  bash
RUN apt-get update && apt-get install -y nodejs

VOLUME /rtorrent
RUN mkdir /rtorrent/log /rtorrent/download /rtorrent/.session && cd /rtorrent/log && touch rtorrent.log tracker.log storage.log
COPY rtorrent.rc /root/.rtorrent.rc

RUN git clone https://github.com/jfurrow/flood.git

COPY flood.config.js /app/flood/config.js
RUN cd flood && npm install && npm run build


CMD rtorrent > /dev/null & cd flood && npm start
