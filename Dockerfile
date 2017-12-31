FROM debian:stable

RUN apt-get update && apt-get install -y curl wget gnupg2 build-essential rtorrent git procps unzip screen
RUN curl -sL https://deb.nodesource.com/setup_8.x |  bash
RUN apt-get update && apt-get install -y nodejs


RUN mkdir /rtorrent && cd /rtorrent && mkdir log .session && cd /rtorrent/log && touch rtorrent.log tracker.log storage.log
COPY rtorrent.rc /root/.rtorrent.rc

#RUN git clone https://github.com/jfurrow/flood.git
RUN wget https://github.com/jfurrow/flood/archive/v1.0.0.zip && unzip v1.0.0.zip && ls && mv flood-1.0.0 flood
COPY flood.config.js /flood/config.js
RUN cd flood && npm install && npm run build-assets

VOLUME ["/rtorrent/log","/rtorrent/.session"]

CMD touch /rtorrent/.session/rtorrent.lock && rm /rtorrent/.session/rtorrent.lock && cd flood && screen -S flood -dm rtorrent && sleep 3  && screen -S flood -dm npm start && tail -f /dev/null
