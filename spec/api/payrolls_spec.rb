# frozen_string_literal: true

resource "Payrolls" do
  explanation "Calculate player payrolls"
  header "Content-Type", "application/json"

  let(:response) { JSON.parse(response_body).with_indifferent_access }

  before do
    do_request(payload)
  end

  post "/v1/payrolls" do
    context "200" do
      parameter :jugadores, "Array of players", required: true

      let(:payload) { base_payload }
      let(:luis) { response.dig(:jugadores).detect { |this| this[:nombre] =~ /luis/i } }

      context "with no explicit tabulator (using default tabulator)" do
        example "Calculate payrolls" do
          expect(status).to eq(200)
          # Based on example on README
          expect(luis[:sueldo_completo]).to eq 59_550.0
        end
      end

      context "with custom tabulator" do
        parameter :equipos, "Array of team tabulators"

        let(:equipos) { [team_payload] }

        let(:payload) do
          base_payload.tap do |payload|
            payload[:equipos] = [
              {
                equipo: "rojo",
                niveles: {
                  "A" => 20,
                  "B" => 30,
                  "C" => 40,
                  "Cuauh" => 50
                }
              }
            ]
          end
        end

        example "Calculate payrolls with custom tabulator" do
          expect(status).to eq(200)
          expect(luis[:sueldo_completo]).to eq 53_614
        end
      end
    end

    context "400" do
      context "with INVALID player data" do
        let(:payload) do
          {jugadores: Array.new(5) { player_payload(equipo: nil) }}
        end

        example "Invalid request: player has no team" do
          expect(status).to eq(400)
        end
      end

      context "with INVALID team name" do
        let(:payload) do
          {
            jugadores: Array.new(5) { player_payload },
            equipos: [team_payload(name: "INVALID")]
          }
        end

        example "Invalid request: team has no name" do
          expect(status).to eq(400)
        end
      end
    end
  end
end
