'use strict';

var gulp = require('gulp');
var vapor = require('gulp-vapor');
var webpack = require('gulp-webpack');

vapor.config.commands.build = 'vapor build';

gulp.task('vapor:start', vapor.start);
gulp.task('vapor:reload', vapor.reload);
gulp.task('webpack', function() {
    gulp.src('./Public/script/src/main.jsx')
    .pipe(webpack( require('./webpack.config.js') ))
    .pipe(gulp.dest('./Public/script/dist/'));
});
gulp.task('watch', function() {
    var vaporTarget = [
        './Sources/**/*',
        './Resources/**/*'
    ];
    gulp.watch(vaporTarget, ['vapor:reload']);
    gulp.watch(['./Public/script/src/*'], ['webpack'])
});

gulp.task('default', ['vapor:start', 'watch']);
