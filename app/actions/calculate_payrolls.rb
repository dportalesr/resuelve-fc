# frozen_string_literal: true

require_relative "base"

module App
  module Actions
    class CalculatePayrolls < Base
      include Hanami::Action
      accept :json

      params do
        required(:jugadores).each { schema(App::Player::Payload) }
        optional(:equipos).each { schema(App::Team::Tabulator) }
      end

      def call(params)
        halt(400) unless params.valid?

        @players_payload = params.dig(:jugadores)
        @tabulators_payload = params.dig(:equipos).to_a

        self.body = {jugadores: teams.map(&:to_payload).flatten}.to_json
      end

      private

      def teams
        @players_payload.each_with_object({}) do |payload, acc|
          team_name = payload[:equipo]
          acc[team_name] ||= App::Team.new(name: team_name, tabulator: find_tabulator_for(team_name))
          acc[team_name].players << App::Player.new(**payload, team: acc[team_name])
        end.values
      end

      def find_tabulator_for(team_name)
        @tabulators_payload.detect { |this| this[:equipo] =~ /#{team_name}/i }&.dig(:niveles)
      end
    end
  end
end
