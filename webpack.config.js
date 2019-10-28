const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

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
  plugins: [
    new HtmlWebpackPlugin({
      template: './src/index.html',
      inject: true,
      minify: {
        removeComments: true,
        collapseWhitespace: false
      }
    }),
    new CopyWebpackPlugin([
      {
        from: 'gml',
        to: 'gml'
      }
    ])
  ],
  mode: "development",
};
