# frozen_string_literal: true

module TestHelpers
  def player_payload(atts = {})
    atts.transform_keys!(&:to_sym)
    names = %w[Alice Bob Carlos Diana Elizabeth Felix]

    {
      nombre: "#{names.sample} #{("A".."Z").to_a.sample}",
      nivel: App::Team::LEVELS.sample,
      goles: (0..10).to_a.sample,
      sueldo: (40..80).to_a.sample * 1000,
      bono: (20..40).to_a.sample * 1000,
      equipo: App::Team::LIST.sample
    }.merge(atts)
  end

  def team_payload(name: nil, tabulator: nil)
    name ||= App::Team::LIST.sample
    tabulator ||= tabulator_payload

    {
      equipo: name,
      niveles: tabulator
    }
  end

  def tabulator_payload
    goals = []
    goals << (1..20).to_a.sample until goals.uniq.count == App::Team::LEVELS.count
    App::Team::LEVELS.zip(goals.sort).to_h
  end

  def base_payload
    {
      jugadores: [
        {
          nombre: "Juan Pérez",
          nivel: "A",
          goles: 6,
          sueldo: 20_000,
          bono: 5_000,
          equipo: "rojo"
        },
        {
          nombre: "Pedro Páramo",
          nivel: "B",
          goles: 7,
          sueldo: 30_0000,
          bono: 6_000,
          equipo: "rojo"
        },
        {
          nombre: "Martín Torres",
          nivel: "C",
          goles: 16,
          sueldo: 40_000,
          bono: 8_000,
          equipo: "rojo"
        },
        {
          nombre: "Luis Hernández",
          nivel: "Cuauh",
          goles: 19,
          sueldo: 50_000,
          bono: 10_000,
          equipo: "rojo"
        }
      ]
    }
  end
end
