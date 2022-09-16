const { createProxyMiddleware } = require('http-proxy-middleware');

module.exports = function(app) {
  app.use(
    '/api',
    createProxyMiddleware({
      target: process.env.PROMETHEUS_SRC_API,
      changeOrigin: true,
    })
  );
};
