# Karma configuration
module.exports = (config) ->
  config.set
    basePath: "../"

    frameworks: [
      "mocha"
      "chai"
    ]

    # list of files / patterns to load in the browser
    files: require("./karma-files").files

    preprocessors:
      "**/*.html": ["html2js"]

      "app/scripts/**/*.coffee": ["coverage"]
      "test/unit/**/*.coffee": ["coffee"]

    ngHtml2JsPreprocessor:
      stripPrefix: "app/"
      moduleName: "myApp.templates"

    # Test results reporter to use. Possible values: dots || progress || growl
    reporters: ["dots", "coverage"]

    # html - produces a bunch of HTML files with annotated source code
    # lcovonly - produces an lcov.info file
    # lcov - produces html + lcov files. This is the default format
    # cobertura - produces a cobertura-coverage.xml file for easy Hudson integration
    # text-summary - produces a compact text summary of coverage, typically to console
    # text - produces a detailed text table with coverage for all files
    coverageReporter:
      type: "text-summary"
      dir: "coverage"

    # web server port
    port: 8080

    # cli runner port
    runnerPort: 9100

    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true

    # Start these browsers, currently available:
    # - Chrome
    # - ChromeCanary
    # - Firefox
    # - Opera
    # - Safari (only Mac)
    # - PhantomJS
    # - IE (only Windows)
    browsers: ["PhantomJS"]

    # Continuous Integration mode
    # if true, it capture browsers, run tests and exit
    singleRun: false

    # level of logging
    # possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel: config.LOG_WARN

    plugins: [
      "karma-coffee-preprocessor"
      "karma-ng-html2js-preprocessor"

      "karma-mocha"
      "karma-chai-plugins"
      "karma-spec-reporter"
      "karma-coverage"

      "karma-phantomjs-launcher"
      "karma-chrome-launcher"
      "karma-firefox-launcher"
      "karma-opera-launcher"
    ]
