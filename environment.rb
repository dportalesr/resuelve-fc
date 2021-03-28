require "bundler/setup"
Bundler.require :default, ENV.fetch("RACK_ENV", "development")

require "active_support/core_ext"
require "hanami/middleware/body_parser"
require_relative "app/middleware"

Dir["./app/*.rb"].sort.each { |f| require f }
Dir["./app/actions/*.rb"].sort.each { |f| require f }

APP_ROOT = File.expand_path(".", __dir__)

Raddocs.configure do |c|
  c.docs_dir = Pathname.new File.join(APP_ROOT, "docs")
end

# TODO: Implement *real* storage
Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new
Rack::Attack.throttle("requests by ip", limit: 5, period: 2) { |req| req.ip }
