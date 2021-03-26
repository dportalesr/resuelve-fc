# frozen_string_literal: true

require_relative "environment"

class ResuelveFc < Hanami::API
  get "/" do
    "Hello world"
  end
end
