require "bundler/setup"
Bundler.require :default, ENV.fetch("RACK_ENV", "development")

APP_ROOT = File.expand_path(".", __dir__)
