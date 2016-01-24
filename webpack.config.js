var path = require('path');
var webpack = require('webpack');

module.exports = {
  // entry: "./client/router.cjsx",
  entry: "./client/start.coffee",
  output: {
    path: path.join(__dirname, "public"),
    filename: 'main.js'
  },
  resolveLoader: {
    modulesDirectories: ['node_modules']
  },
  resolve: {
    extensions: [
      '',
      '.js',
      '.coffee'
    ]
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loader: 'coffee' }
    ]
  }
};
