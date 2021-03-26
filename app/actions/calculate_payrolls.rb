require_relative "base"

module App
  module Actions
    class CalculatePayrolls < Base
      include Hanami::Action

      params do
        required(:jugadores).each { schema(App::Player) }
        optional(:equipos).each { schema(App::Team) }
      end

      def call(params)
        halt(400) unless params.valid?
      end
    end
  end
end
