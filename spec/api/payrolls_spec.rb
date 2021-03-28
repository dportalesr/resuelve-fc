# frozen_string_literal: true

resource "Payrolls" do
  explanation "Calculate player payrolls"
  header "Content-Type", "application/json"

  let(:response) { JSON.parse(response_body).with_indifferent_access }

  before do
    do_request(payload)
  end

  post "/v1/payrolls" do
    let(:player) { player_payload }
    let(:team) { team_payload }

    context "200" do
      parameter :jugadores, type: :array, items: {method: :player, with_example: true}, required: true
      parameter :equipos, type: :array, items: {method: :team, with_example: true}

      let(:payload) do
        base_payload
      end

      let(:luis) { response.dig(:jugadores).detect { |this| this[:nombre] =~ /luis/i } }

      context "with no explicit tabulator (using default tabulator)" do
        example "Calculate payrolls" do
          expect(status).to eq(200)

          # Based on example on README
          expect(luis[:sueldo_completo]).to eq 59_550.0
        end
      end

      context "with custom tabulator" do
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
