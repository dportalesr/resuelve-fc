# frozen_string_literal: true

require_relative "base"
require_relative "team"

module App
  class Player < Base
    class Payload
      include Hanami::Validations

      validations do
        required(:nombre).filled(:str?)
        required(:nivel).filled(:str?, included_in?: App::Team::LEVELS)
        required(:goles).filled(:int?)
        required(:sueldo).filled(:int?)
        required(:bono).filled(:int?)
        required(:equipo).filled(:str?)

        optional(:sueldo_completo)
      end
    end

    include Hanami::Validations

    attr_accessor :name, :level, :score, :base_salary, :bonus, :team

    validations do
      required(:name).filled(:str?)
      required(:level).filled(:str?, included_in?: App::Team::LEVELS)
      required(:score).filled(:int?)
      required(:base_salary).filled(:decimal?)
      required(:bonus).filled(:decimal?)
      required(:team).filled
    end

    def initialize(atts = {})
      @name = atts[:nombre]
      @level = atts[:nivel]
      @score = atts[:goles].to_i
      @base_salary = atts[:sueldo].to_f
      @bonus = atts[:bono].to_f
      @team = atts[:team]
    end

    def to_payload
      {
        nombre: name,
        nivel: level,
        goles: score,
        sueldo: base_salary,
        bono: bonus,
        sueldo_completo: full_salary,
        equipo: team.name
      }
    end

    def full_salary
      base_salary + (bonus * performance)
    end

    def performance
      [team.performance, personal_performance].sum / 2.0
    end

    def personal_performance
      return 0 if expected_score.zero?

      score.to_i / expected_score.to_f
    end

    def expected_score
      team.tabulator[level].to_i
    end
  end
end
