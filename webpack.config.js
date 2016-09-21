const __PRODUCTION__ = process.env.WEBPACK_ENV == 'production'
var webpack = require('webpack')
var path = require('path')

if (__PRODUCTION__) {
  var UglifyJsPlugin = require('webpack/lib/optimize/UglifyJsPlugin')
  var ExtractTextPlugin = require('extract-text-webpack-plugin')
}

var filename = __PRODUCTION__ ? '[name]-[hash].js' : '[name].js'
var styleLoader = __PRODUCTION__ ? ExtractTextPlugin.extract('style', 'css?minimize!postcss!sass') : 'style!css!postcss!sass'
var fileLoader = __PRODUCTION__ ? 'file?name=[name]-[hash].[ext]' : 'file?name=[name].[ext]'
var plugins = [
  function() {
    this.plugin('done', function(stats) {
      require('fs').writeFileSync(__dirname + '/stats.json', JSON.stringify(stats.toJson({
        source: false, chunks: false, modules: false, children: false
      })))
    })
  },
  new webpack.ProvidePlugin({
    'fetch': 'imports?this=>global!exports?global.fetch!whatwg-fetch'
  }),
  new webpack.DefinePlugin({
    __PRODUCTION__: __PRODUCTION__,
    'process.env': {
      NODE_ENV: __PRODUCTION__ ? "'production'" : "'development'"
    }
  })
]

if (__PRODUCTION__) {
  plugins.push(
    new ExtractTextPlugin('[name]-[hash].css'),
    new UglifyJsPlugin()
  )
}

module.exports = [
  {
    entry: {
      dashboard: ['babel-polyfill', './app/assets/javascripts/dashboard'],
      landing: './app/assets/landing'
    },
    output: {
      path: __dirname + '/public/assets',
      filename: filename,
      publicPath: '/assets/'
    },
    resolve: {
      root: [
        path.resolve('./app/assets/javascripts/dashboard')
      ],
      modulesDirectories: [
        'containers', 'components',
        'web_modules', 'node_modules'
      ]
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
          presets: ['react', 'es2015', 'stage-0', 'stage-2']
        }
      }]
    },
    postcss: function() {
      return [require('autoprefixer')]
    }
  },
  require('./webpack/webpack.config.server')
]
