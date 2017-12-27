const CONFIG = {
  baseURI: '/',
  dbCleanInterval: 1000 * 60 * 60,
  dbPath: '/rtorrent/flood/',
  floodServerHost: '0.0.0.0',
  floodServerPort: 3000,
  floodServerProxy: 'http://kiralex.me:3000',
  maxHistoryStates: 30,
  pollInterval: 1000 * 5,
  secret: 'flood',
  scgi: {
    host: 'localhost',
    port: 5000,
    socket: false,
    socketPath: '/tmp/rtorrent.sock',
  },
  ssl: true,
  sslKey: '/rtorrent/sslKey.pem',
  sslCert: '/rtorrent/sslCert.pem',
  torrentClientPollInterval: 1000 * 2,
};

module.exports = CONFIG;
