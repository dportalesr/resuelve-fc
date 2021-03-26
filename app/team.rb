# frozen_string_literal: true

require_relative "base"

module App
  class Team < Base
    include Hanami::Validations

    LIST = %w[rojo azul negro amarillo].freeze
    LEVELS = %w[A B C Cuauh].freeze

    validations do
      required(:equipo).filled(:str?, included_in?: LIST)
      required(:niveles).schema do
        LEVELS.each do |level|
          required(level.to_sym).filled(:int?, gt?: 0)
        end
      end
    end
  end
end
