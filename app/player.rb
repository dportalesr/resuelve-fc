# frozen_string_literal: true

require_relative "base"
require_relative "team"

module App
  class Player < Base
    include Hanami::Validations

    attr_accessor :nombre, :nivel, :goles, :sueldo, :bono, :sueldo_completo, :equipo

    validations do
      required(:nombre).filled(:str?)
      required(:nivel).filled(:str?, included_in?: App::Team::LEVELS)
      required(:goles).filled(:int?)
      required(:sueldo).filled(:int?)
      required(:bono).filled(:int?)
      required(:equipo).filled(:str?)

      optional(:sueldo_completo).filled(:int?)
    end
  end
end
