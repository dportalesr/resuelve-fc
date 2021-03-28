# frozen_string_literal: true

require_relative "environment"

class ResuelveFc < Hanami::API
  use Hanami::Middleware::BodyParser, :json

  scope :v1 do
    scope :payrolls do
      post "/", to: App::Actions::CalculatePayrolls.new
    end
  end

  mount Raddocs::App, at: "/docs"
end
