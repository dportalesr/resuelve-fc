# frozen_string_literal: true

resource "Payrolls" do
  explanation "Calculate player payrolls"
  header "Content-Type", "application/json"

  let(:response) { JSON.parse(response_body).with_indifferent_access }

  before do
    do_request(payload)
  end

  post "/v1/payrolls" do
    let(:player) { make_player }
    let(:team) { make_team }

    parameter :jugadores, type: :array, items: {method: :player, with_example: true}, required: true
    parameter :equipos, type: :array, items: {method: :team, with_example: true}

    context "200" do
      context "with no explicit tabulator (using default tabulator)" do
        let(:payload) do
          {}
        end

        let(:luis) { response.dig(:jugadores).detect { |this| this[:nombre] =~ /luis/i } }

        example "Calculate payrolls" do
          expect(status).to eq(200)

          expect(luis[:sueldo_completo]).to eq 59_550.0
        end
      end
    end

    context "400" do
      context "with empty payload" do
        let(:payload) do
          {}
        end

        example "Invalid request: No payload" do
          expect(status).to eq(400)
        end
      end

      context "with INVALID player data" do
        let(:payload) do
          {jugadores: Array.new(5) { make_player(equipo: nil) }}
        end

        example "Invalid request: player has no team" do
          expect(status).to eq(400)
        end
      end

      context "with INVALID team name" do
        let(:payload) do
          {
            jugadores: Array.new(5) { make_player },
            equipos: [make_team(name: "INVALID")]
          }
        end

        example "Invalid request: team has no name" do
          expect(status).to eq(400)
        end
      end
    end
  end
end
