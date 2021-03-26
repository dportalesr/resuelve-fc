require "bundler/setup"
Bundler.require :default, ENV.fetch("RACK_ENV", "development")

Dir["./app/*.rb"].sort.each { |f| require f }

APP_ROOT = File.expand_path(".", __dir__)
