class PokemonController < ApplicationController

=begin
    Cambio el contador de pokemons en la DB con un simple @pokemon.length
    https://stackoverflow.com/questions/6083219/activerecord-size-vs-count
=end

  # rescue_from Exception do |e|
  #   render json: {error: e.message}, status: :internal_error
  # end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end

  # GET /pokemon
  def index
    pokemon = Pokemon.paginate(page: params[:page], per_page: 20)
    
    if pokemon.empty?
      # puts "here empty"
      render json: {}
    else
        render json: PokemonIndexService.res(pokemon, Pokemon.count)
    end
  end

  # GET /pokemon/{id}
  def show
    poke = PokemonFindService.find(Pokemon, params[:id])
    if !poke.nil?
      render json: poke
    else
      render json: { error: "Pokemon not found" }, status: :not_found
    end
  end

  #  POST /pokemon
  def create
    parsed_body = JSON.parse(request.body.read)
    # puts "Buscando ANDO params = #{parsed_body['pokemon']['name']}"
    poke_find =  Pokemon.find_by(name: parsed_body['pokemon']['name'])
  
    if poke_find.nil?
      # puts "NOOOOO ENcontrado"
      @poke = Pokemon.create!(PokemonParams.create(params))
      render json: @poke
    elsif
      render json: {error: "Pokemon exist"}, status: 409
    end
  end

  # PUT /pokemon/{id} 
  def update
    @poke = PokemonFindService.find(Pokemon, params[:id])
    if !@poke.nil?
      @poke.update!(PokemonParams.update(params))
      @poke_json = @poke.slice(:id, :name, :type_1, :type_1, :type_2, :total, :hp, :attack,
          :defense, :sp_atk, :sp_def, :speed, :generation, :legendary)
      render json: @poke_json
    else 
      render json: { error: "Pokemon not found" }, status: :not_found
    end
  end

end
