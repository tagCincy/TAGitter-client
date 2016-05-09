browserSync  = require('browser-sync')
watchify     = require('watchify')
browserify   = require('browserify')
source       = require('vinyl-source-stream')
buffer       = require('vinyl-buffer')
gulp         = require('gulp')
preprocess   = require("gulp-preprocess")
ngannotate   = require "gulp-ng-annotate"
gutil        = require('gulp-util')
gulpSequence = require('gulp-sequence')
processhtml  = require('gulp-jade')
sass         = require('gulp-sass')
autoprefixer = require('gulp-autoprefixer')
watch        = require('gulp-watch')
minifycss    = require('gulp-minify-css')
uglify       = require('gulp-uglify')
streamify    = require('gulp-streamify')
sourcemaps   = require('gulp-sourcemaps')
concat       = require('gulp-concat')

prod = gutil.env.NODE_NV is "production"

onError = (err) ->
  console.log err.message
  @emit 'end'

gulp.task 'bundle-vendor', ->
  watchify(browserify('./src/coffee/vendor',
    transform: ['coffeeify']
    extensions: ['.coffee']
    cache: {}
    packageCache: {}
    fullPaths: true
  ))
  .bundle().on 'error', onError
  .pipe source("vendor.coffee")
  .pipe buffer()
  .pipe sourcemaps.init()
  .pipe concat("vendor.js")
  .pipe `!prod ? sourcemaps.write('.') : gutil.noop()`
  .pipe `prod ? streamify(uglify()) : gutil.noop()`
  .pipe gulp.dest('./public/js')
  .pipe browserSync.stream()

gulp.task 'bundle-app', ->
  watchify(browserify('./src/coffee/angular/app',
    transform: ['coffeeify']
    extensions: ['.coffee']
    cache: {}
    packageCache: {}
    fullPaths: true
  ))
  .bundle().on 'error', onError
  .pipe source("app.coffee")
  .pipe buffer()
  .pipe sourcemaps.init()
  .pipe ngannotate()
  .pipe concat("app.js")
  .pipe `!prod ? sourcemaps.write('.') : gutil.noop()`
  .pipe `prod ? streamify(uglify()) : gutil.noop()`
  .pipe gulp.dest('./public/js')
  .pipe browserSync.stream()

gulp.task 'js', ['bundle-vendor', 'bundle-app']

gulp.task 'html', () ->
  gulp.src './src/templates/**/*.pug'
  .pipe processhtml()
  .pipe gulp.dest('./public/')
  .pipe browserSync.stream()

gulp.task 'sass', () ->
  gulp.src './src/scss/**/*.scss'
  .pipe sass(
    includePaths: [].concat(['node_modules/foundation-sites/scss'])
  )
  .on 'error', onError
  .pipe `prod ? minifycss() : gutil.noop()`
  .pipe `prod ? autoprefixer({
      browsers: ['last 2 versions'],
      cascade: false
    }) : gutil.noop()`
  .pipe gulp.dest('./public/stylesheets')
  .pipe browserSync.stream()
  
gulp.task "env", ->
  gulp.src "./src/js/env.js"
  .pipe preprocess()
  .pipe gulp.dest('./public/js')
  
gulp.task 'serve', () ->
  browserSync.init
    server:
      baseDir: './public'
  gulp.watch './src/templates/**/*', ['html']
  gulp.watch './src/scss/**/*.scss', ['sass']

gulp.task('default', gulpSequence(['env', 'html', 'sass', 'js'], 'serve'))
