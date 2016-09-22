const __PRODUCTION__ = process.env.WEBPACK_ENV == 'production'
var path = require('path')

module.exports = {
  entry: './app/assets/landing/server',
  output: {
    path: path.resolve(__dirname, '../lib'),
    filename: 'server.js',
    publicPath: '/assets/'
  },
  resolve: {
    root: [
      path.resolve(__dirname, '../app/assets/landing')
    ],
    modulesDirectories: [
      'containers', 'components',
      'web_modules', 'node_modules'
    ]
  },
  module: {
    loaders: [{
      test: /\.css$/,
      loader: 'css'
    }, {
      test: /\.jpg$/,
      loader: 'file',
      query: {
        emitFile: false,
        name: __PRODUCTION__ ? '[name]-[hash].[ext]' : '[name].[ext]'
      }
    }, {
      test: /\.js$/,
      exclude: /node_modules/,
      loader: 'babel',
      query: {
        presets: ['react', 'es2015', 'stage-0', 'stage-2']
      }
    }]
  }
}
