# frozen_string_literal: true

require "hanami/controller"
require "hanami/validations"

Hanami::Controller.configure do
  handle_exceptions ENV["RACK_ENV"] == "production"
  default_request_format :json
  default_response_format :json
end

module App
  module Actions
    class Base
    end
  end
end
