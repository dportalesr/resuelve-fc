# frozen_string_literal: true

resource "Payrolls" do
  explanation "Calculate player payrolls"
  header "Content-Type", "application/json"

  post "/v1/payrolls" do
    let(:player) { make_player }
    let(:team) { make_team }

    parameter :jugadores, type: :array, items: {method: :player, with_example: true}, required: true
    parameter :equipos, type: :array, items: {method: :team, with_example: true}

    context "200" do
      let(:payload) do
        {jugadores: Array.new(5) { make_player }}
      end

      example "Calculate payrolls" do
        expect(status).to eq(200)
      end
    end

    context "400" do
      context "with empty payload" do
        let(:payload) do
          {}
        end

        example "Invalid request: No payload" do
          do_request(payload)
          expect(status).to eq(400)
        end
      end

      context "with INVALID player data" do
        let(:payload) do
          {jugadores: Array.new(5) { make_player(equipo: nil) }}
        end

        example "Invalid request: player has no team" do
          do_request(payload)
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
          do_request(payload)
          expect(status).to eq(400)
        end
      end
    end
  end
end
