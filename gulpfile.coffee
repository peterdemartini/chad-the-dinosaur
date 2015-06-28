server        = require 'gulp-webserver'
gulp          = require 'gulp'
concat        = require 'gulp-concat'
gutil         = require 'gulp-util'
less          = require 'gulp-less'
watch         = require 'gulp-autowatch'
webpack       = require 'webpack'
webpackConfig = require './webpack.config'


gulp.task 'less', ->
  gulp
    .src './client/less/**/*.less'
    .pipe concat('styles.less')
    .pipe less()
    .pipe concat('styles.css')
    .pipe gulp.dest('./public')

gulp.task 'server', ->
  gulp
    .src 'public'
    .pipe server
      livereload: true,
      directoryListing: false,
      open: true,
      fallback: 'index.html'

gulp.task 'webpack', ->
  webpack webpackConfig, (err, stats) ->
    throw new gutil.pluginError 'webpack', err if err

gulp.task 'watch', ->
  watch gulp,
    less: './client/less/**/*.less'
    webpack: [
      './client/**/*.js'
      './client/**/*.jsx'
      # './client/**/*.cjsx'
      './client/**/*.coffee'
    ]

gulp.task 'build', ['webpack', 'less']

gulp.task 'default', ['build', 'watch', 'server']
