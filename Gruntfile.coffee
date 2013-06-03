module.exports = (grunt) ->
  version = ->
    grunt.file.readJSON("package.json").version
  version_tag = ->
    "v#{version()}"

  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    comments: """
// Chosen, a Select Box Enhancer for jQuery and Protoype
// by Patrick Filler for Harvest, http://getharvest.com
//
// Version <%= pkg.version %>
// Full source at https://github.com/harvesthq/chosen
// Copyright (c) 2011 Harvest http://getharvest.com

// MIT License, https://github.com/harvesthq/chosen/blob/master/LICENSE.md
// This file is generated by `grunt build`, do not edit it by hand.\n
"""

    concat:
      options:
        banner: "<%= comments %>"
      jquery:
        src: ["public/chosen.jquery.js"]
        dest: "public/chosen.jquery.js"
      proto:
        src: ["public/chosen.proto.js"]
        dest: "public/chosen.proto.js"

    coffee:
      compile:
        files:
          'public/chosen.jquery.js': ['coffee/lib/select-parser.coffee', 'coffee/lib/abstract-chosen.coffee', 'coffee/chosen.jquery.coffee']
          'public/chosen.proto.js': ['coffee/lib/select-parser.coffee', 'coffee/lib/abstract-chosen.coffee', 'coffee/chosen.proto.coffee']

    uglify:
      options:
        mangle:
          except: ['jQuery']
        banner: "<%= comments %>"
      my_target:
        files:
          'public/chosen.jquery.min.js': ['public/chosen.jquery.js']
          'public/chosen.proto.min.js': ['public/chosen.proto.js']

    watch:
      scripts:
        files: ['coffee/**/*.coffee']
        tasks: ['build']

    shell:
      with_clean_repo:
        command: 'git diff --exit-code'
      without_existing_tag:
        command: 'git tag'
        options:
          callback: (err, stdout, stderr, cb) ->
            if stdout.split("\n").indexOf( version_tag() ) >= 0
              throw 'This tag has already been committed to the repo.'
            else
              cb()
      tag_release:
        command: "git tag -a #{version_tag()} -m 'Version #{version()}'" 
      push_repo:
        commmand: "git push; git push --tags"
        options:
          callback: (err, stdout, stderr, cb) ->
            if err
              console.log "Failure to tag caught"
              grunt.task.run 'shell:untag_release'
              throw 'Failed to tag. Removing tag.'
            else
              console.log "Successfully tagged #{version_tag()}: https://github.com/harvesthq/chosen/tree/#{version_tag()}"
            cb()
      untag_release:
        command: "git tag -d #{version_tag()}"

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-shell'

  grunt.registerTask 'build', ['coffee', 'concat', 'uglify']

  grunt.registerTask 'release', 'build, tag the current release, and push', () ->
    grunt.task.run ['shell:with_clean_repo', 'shell:without_existing_tag', 'build', 'package_jquery', 'shell:tag_release', 'shell:push_repo']

  grunt.registerTask 'package_jquery', 'Generate a jquery.json manifest file from package.json', () =>
    src = "package.json"
    dest = "chosen.jquery.json"
    pkg = grunt.file.readJSON(src)
    json1 =
      "name": pkg.name
      "title": pkg.title
      "description": pkg.description
      "version": version()
      "licenses": pkg.licenses
    json2 = pkg.jqueryJSON
    json1[key] = json2[key] for key of json2
    json1.author.name = pkg.author
    grunt.file.write('chosen.jquery.json', JSON.stringify(json1, null, 2))