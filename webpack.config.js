const __PRODUCTION__ = process.env.WEBPACK_ENV == 'production'

if (__PRODUCTION__) {
  var UglifyJsPlugin = require('webpack/lib/optimize/UglifyJsPlugin')
  var ExtractTextPlugin = require('extract-text-webpack-plugin')
}

var filename = __PRODUCTION__ ? '[name]-[hash].js' : '[name].js'
var styleLoader = __PRODUCTION__ ? ExtractTextPlugin.extract('style', 'css!postcss!sass') : 'style!css!postcss!sass'
var fileLoader = __PRODUCTION__ ? 'file?name=[name]-[hash].[ext]' : 'file?name=[name].[ext]'
var plugins = [
  function() {
    this.plugin('done', function(stats) {
      require('fs').writeFileSync(__dirname + '/stats.json', JSON.stringify(stats.toJson()))
    })
  }
]

if (__PRODUCTION__) {
  plugins.push(
    new ExtractTextPlugin('[name]-[hash].css'),
    new UglifyJsPlugin()
  )
}

module.exports = {
  entry: {
    app: './app/assets/javascripts/app.js',
    mobile: './app/assets/javascripts/mobile.js'
  },
  output: {
    path: __dirname + '/public/assets',
    filename: filename,
    publicPath: '/assets/'
  },
  plugins: plugins,
  module: {
    loaders: [{
      test: /\.s?css$/,
      loader: styleLoader
    }, {
      test: /\.(jpg|png|gif|ttf|eot|svg|woff2?|swf)(\?.+)?$/,
      loader: fileLoader
    }, {
      test: /\.coffee$/,
      loader: 'coffee'
    }, {
      test: /\.jsx?$/,
      exclude: /node_modules/,
      loader: 'babel',
      query: {
        presets: ['react', 'es2015', 'stage-2']
      }
    }]
  },
  postcss: function() {
    return [require('autoprefixer')]
  }
}