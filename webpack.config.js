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
    libraryTarget: 'var',
    library: 'raytracer'
  },
  resolve: {
    extensions: ['.js', '.wasm']
  },
  mode: "development",
};
