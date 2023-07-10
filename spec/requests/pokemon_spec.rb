require 'rails_helper'

RSpec.describe "Pokemons", type: :request do
  describe "GET /pokemon" do
    it "returns http success" do
      get "/pokemon"
      payload = JSON.parse(response.body)
      # puts "Paylod Empty = #{payload}"
      expect(payload).to be_empty
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /pokemon - With data in the DB" do
    let!(:pokis) { create_list(:pokemon, 10) }
    it "returns http success and all the poke db" do

      # puts "SIZE de ALGO #{pokis.size}"
      get "/pokemon"
      payload = JSON.parse(response.body)
      # puts "Paylod con datos = #{payload}"
      expect(payload.size).to eq(4)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /pokemon/{id}" do
    let!(:pokis) { create(:pokemon) }
    it "returns htt success and one poke by id" do
      # pokemon1 = Pokemon.create!({name: "pk1", type_1: "pru1", total: 32, attack: 32, defense: 32})
      get "/pokemon/#{pokis.id}"
      payload = JSON.parse(response.body)
      # puts "Paylod Un solo POke = #{payload}"
      expect(payload.size).to eq(13)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /pokemon" do
  
    it "returns http success" do
      pokemon_params = {
          name: "pk9",
          type_1: "test_1",
          total: 32,
          hp: 42,
          attack: 32, 
          defense: 32
      }

      expect {
        post "/pokemon", params: { pokemon: pokemon_params }.to_json, headers: { 'Content-Type' => 'application/json' }
      }.to change(Pokemon, :count).by(1)
      payload = JSON.parse(response.body)
      # puts "Reponse = #{response.body}"
      expect(payload["name"]).to eq("pk9")
      expect(payload["type_1"]).to eq("test_1")
      expect(payload).to_not be_empty
      expect(payload["id"]).to_not be_nil
      expect(response).to have_http_status(:success)
    end

    it "should return error message on invalid post" do
      pokemon_params = {
          type_1: "test_1",
          total: 32,
          hp: 42,
          attack: 32, 
          defense: 32
      }
      # POST HTTP

      # post "/pokemon", params: pokemon_params
      post "/pokemon", params: { pokemon: pokemon_params }.to_json, headers: { 'Content-Type' => 'application/json' }

      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["error"]).to_not be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT /pokemon/{id}" do
  let!(:pokis) { create(:pokemon) }
  
    it "Update a post" do
      pokemon_params = {
        pokemon: {
          name: "test_42",
        }
      }

      put "/pokemon/#{pokis.id}", params: pokemon_params
      payload = JSON.parse(response.body)
      # puts payload
      expect(payload).to_not be_empty
      expect(payload["id"]).to eq(pokis.id)
      expect(response).to have_http_status(:success)
    end
  end
end
