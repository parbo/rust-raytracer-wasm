const path = require('path');

module.exports = {
  entry: "./src/bootstrap.js",
  module: {
    rules: [
      {
        test: /\.wasm$/,
        type: 'javascript/auto',
        loaders: ['file-loader'],
      }
    ]
  },
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "bootstrap.js",
  },
  resolve: {
    extensions: ['.js', '.wasm']
  },
  mode: "development",
};
