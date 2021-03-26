require "bundler/setup"
Bundler.require :default, ENV.fetch("RACK_ENV", "development")

require "active_support/core_ext"
require "hanami/middleware/body_parser"

Dir["./app/*.rb"].sort.each { |f| require f }
Dir["./app/actions/*.rb"].sort.each { |f| require f }

APP_ROOT = File.expand_path(".", __dir__)
