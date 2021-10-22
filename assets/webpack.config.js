export default (env, options) => ({
  // ...
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
        },
      },
      {
        test: /\.css$/,
        use: [MiniCssExtractPlugin.loader, "css-loader"],
      },
      {
        test: /\.elm$/,
        exclude: ["/elm-stuff/", "/node_modules"],
        loader: "elm-webpack-loader",
        options: {
          debug: true,
          // NOTE: `warn` option was removed in Elm 0.19.
          // Re-enable if desired for use in Elm 0.18.
          // warn: true,
          pathToElm: "node_modules/.bin/elm",
        },
      },
    ],
  },
  //...
});
