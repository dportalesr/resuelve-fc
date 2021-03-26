# frozen_string_literal: true

module TestHelpers
  def make_player(atts = {})
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

  def make_team(name: nil, tabulator: nil)
    name ||= App::Team::LIST.sample
    tabulator ||= make_team_tabulator

    {
      equipo: name,
      niveles: tabulator
    }
  end

  def make_team_tabulator
    goals = []
    goals << (1..20).to_a.sample until goals.uniq.count == App::Team::LEVELS.count
    App::Team::LEVELS.zip(goals.sort).to_h
  end
end
