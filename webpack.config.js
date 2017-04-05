const fs = require('fs');
const webpack = require("webpack");
const ExtractTextPlugin = require("extract-text-webpack-plugin");

const prod = process.argv.indexOf('-p') !== -1;
const css_output_template = prod ? "assets/[name]-[hash].css" : "stylesheets/[name].css";
const js_output_template = prod ? "assets/[name]-[hash].js" : "javascripts/[name].js";

module.exports = {
  context: __dirname + "/app/assets",
  entry: {
    application: ['jquery', 'jquery-ujs', 'uikit', "./javascripts/application.js", "./stylesheets/application.scss"]
  },

  output: {
    path: __dirname + "/public",
    filename: js_output_template,
  },

  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel',
        query: {
          presets: ['es2015']
        }
      },
      {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract("css!sass")
      },
      {test: require.resolve('jquery'), loader: 'expose?jQuery'},
      {test: require.resolve('jquery'), loader: 'expose?$'},
      {test: require.resolve('uikit'), loader: 'expose?uikit'},
    ]
  },

  plugins: [
    new ExtractTextPlugin(css_output_template),

    function() {
      // delete previous outputs
      this.plugin("compile", function() {
        let basepath = __dirname + "/public";
        let paths = ["/javascripts", "/stylesheets", "/assets"];

        for (let x = 0; x < paths.length; x++) {
          const asset_path = basepath + paths[x];

          fs.readdir(asset_path, function(err, files) {
            if (files === undefined) {
              return;
            }

            for (let i = 0; i < files.length; i++) {
              fs.unlinkSync(asset_path + "/" + files[i]);
            }
          });
        }
      });

      // output the fingerprint
      this.plugin("done", function(stats) {
        let output = "ASSET_FINGERPRINT = \"" + stats.hash + "\""
        fs.writeFileSync("config/initializers/fingerprint.rb", output, "utf8");
      });
    }
  ]
};