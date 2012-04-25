path = require 'path'
{ run, compileScript, minifyScript, writeFile, notify } = require 'muffin'

task 'compile', 'compile coffeescript → javascript', (options) ->
    run
        options:options
        after:options.after
        files:[
            "./src/**/*.coffee"
        ]
        map:
            'src/adapter/(.+).coffee': (m) ->
                compileScript m[0], path.join("adapter" ,"#{m[1]}.js"), options
            'src/(.+).coffee': (m) ->
                compileScript m[0], path.join("lib" ,"#{m[1]}.js"), options

task 'bundle', 'build a browser bundle', (options) ->
    browserify = require 'browserify'
    { createScope } = require 'scopify'
    run
        options:options
        files:[
            "./lib/*.js"
            "./adapter/*.js"
        ]
        map:
            'lib/(list).js': (m) ->
                bundle = browserify({
                        require: path.join(__dirname, m[0])
                        cache: on
                    }).use(createScope require:'./'+m[1]).bundle()
                notify m[0], "successful browserify!"
                filename = "dt-#{m[1]}.browser.js"
                writeFile(filename, bundle, options).then ->
                    minifyScript filename, options
            'adapter/(.*).js': (m) ->
                bundle = browserify({
                        require: path.join(__dirname, m[0])
                        cache: on
                    }).use(createScope require:'./'+m[1]).bundle()
                notify m[0], "successful browserify!"
                filename = "dt-list.#{m[1]}.browser.js"
                writeFile(filename, bundle, options).then ->
                    minifyScript filename, options

task 'build', 'compile && bundle', (options) ->
    timeout = 0
    options.after = ->
        clearTimeout(timeout) if timeout
        timeout = setTimeout( ->
            invoke 'bundle', options
        , 250)
    invoke 'compile'
