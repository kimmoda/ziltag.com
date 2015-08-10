gulp = require('gulp')
$ = require('gulp-load-plugins')()
streamqueue = require('streamqueue')
spawn = require('child_process').spawn

gulp.task 'bundle', ['bundle.js', 'bundle.scss']

###**************###
### Script Tasks ###
###**************###

gulp.task 'bundle.js', ->
  gulp.src [
    'vendor/assets/components/bootstrap/dist/js/bootstrap.js'
    'vendor/assets/components/handlebars/handlebars.js'
    'vendor/assets/javascripts/redactor.js'
    'vendor/assets/javascripts/redactor/*.js'
    'vendor/assets/components/imagesloaded/imagesloaded.pkgd.js'
    'vendor/assets/components/masonry/dist/masonry.pkgd.js'
    'vendor/assets/components/jquery-tags-input/src/jquery.tagsinput.js'
    'vendor/assets/components/slick/dist/slick.js'
    'vendor/assets/components/introjs/intro.js'
    'vendor/assets/components/fetch/fetch.js'
  ]
  .pipe $.concat 'bundle.js'
  .pipe gulp.dest 'app/assets/javascripts'

###*************###
### Style tasks ###
###*************###

gulp.task 'bundle.scss', ->
  gulp.src [
    'vendor/assets/components/font-awesome/css/font-awesome.css'
    'vendor/assets/components/bootstrap/dist/css/bootstrap.css'
    'vendor/assets/stylesheets/redactor.css'
    'vendor/assets/components/jquery-tags-input/src/jquery.tagsinput.css'
    'vendor/assets/components/slick/examples/css/style.css'
    'vendor/assets/stylesheets/slick-theme.scss'
    'vendor/assets/components/introjs/introjs.css'
  ]
  .pipe $.replace /url\((['"]?)[^)]+\/([^)]+(?:eot|woff|woff2|ttf|svg)[^)]*)\1\)/g, 'asset-url(\'$2\')'
  .pipe $.concat('bundle.scss')
  .pipe gulp.dest('app/assets/stylesheets')

###*******###
### Fonts ###
###*******###

gulp.task 'fonts', ->
  gulp.src [
    'vendor/assets/components/bootstrap/fonts/*'
    'vendor/assets/components/font-awesome/fonts/*'
  ]
  .pipe gulp.dest 'vendor/assets/fonts'