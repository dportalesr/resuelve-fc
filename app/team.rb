# frozen_string_literal: true

require_relative "base"

module App
  class Team < Base
    LIST = %w[rojo azul negro amarillo].freeze
    LEVELS = %w[A B C Cuauh].freeze
    DEFAULT_TABULATOR = {
      "A" => 5,
      "B" => 10,
      "C" => 15,
      "Cuauh" => 20
    }.freeze

    class Tabulator
      include Hanami::Validations

      validations do
        required(:equipo).filled(:str?, included_in?: App::Team::LIST)
        required(:niveles).schema do
          LEVELS.each do |level|
            required(level.to_sym).filled(:int?, gt?: 0)
          end
        end
      end
    end

    include Hanami::Validations

    attr_accessor :name, :tabulator, :players

    validations do
      required(:name).filled(:str?, included_in?: LIST)
    end

    def initialize(atts = {})
      @name = atts[:name]
      @tabulator = (atts[:tabulator] || DEFAULT_TABULATOR).transform_keys(&:to_s)
      @players = []
    end

    def performance
      return 0 if expected_score.zero?

      score / expected_score.to_f
    end

    def expected_score
      @expected_score ||= players.sum(&:expected_score)
    end

    def score
      @score ||= players.sum(&:score)
    end

    def to_payload
      players.map(&:to_payload)
    end
  end
end
