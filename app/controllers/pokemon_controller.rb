class PokemonController < ApplicationController

=begin
    Cambio el contador de pokemons en la DB con un simple @pokemon.length
    https://stackoverflow.com/questions/6083219/activerecord-size-vs-count
=end

rescue_from Exception do |e|
  render json: {error: e.message}, status: :internal_error
end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end

  # GET /pokemon
  def index
    @pokemon = Pokemon.all
    
    if @pokemon.empty?
      # puts "here empty"
      render json: {}, status: :ok
    else
        @pokeList = Hash.new
      # puts "por el ELSE me fui"
        @pokemon.each do |u|
            @pokeList[u.name] = {
                name: u.name,
                id: u.id
            }
        end
        @res = {
            count_pokes: @pokeList.length
        }
        @res.merge!(@pokeList)
        render json: @res, status: :ok
    end
  end

  # GET /pokemon/{id}
  def show
    @poke = find_pokemon
    @poke_json = @poke.slice(:id, :name, :type_1, :type_1, :type_2, :total, :hp, :attack,
                :defense, :sp_atk, :sp_def, :speed, :generation, :legendary)
            render json: @poke_json, status: :ok
  end

  #  POST /pokemon
  def create
    # puts "Create esta siendo llamado !!!"
    @poke = Pokemon.create!(create_params)
    # if !@poke
    #   puts "Eror en Params"
    @poke_json = @poke.slice(:id, :name, :type_1, :type_1, :type_2, :total, :hp, :attack,
        :defense, :sp_atk, :sp_def, :speed, :generation, :legendary)
    render json: @poke_json, status: :created
  end

  # PUT /pokemon/{id} 
  def update
    @poke = find_pokemon
    @poke.update!(update_params)
    @poke_json = @poke.slice(:id, :name, :type_1, :type_1, :type_2, :total, :hp, :attack,
        :defense, :sp_atk, :sp_def, :speed, :generation, :legendary)
    render json: @poke_json, status: :ok
  end

  def create_params
    params.require(:pokemon).permit(:name, :type_1, :total, :hp, :attack,
         :defense, :sp_atk, :sp_def, :speed, :generation, :legendary)
  end

  def update_params
    params.require(:pokemon).permit(:name, :total, :hp, :attack, :defense, :sp_atk, :sp_def, :speed)
  end

  def find_pokemon
    search_value = params[:id]

    if search_value.to_i != 0
        @poke = Pokemon.find_by(id: search_value)
    else
        # puts search_value.is_a?(String)
        @poke = Pokemon.find_by(name: search_value)
    end

    if @poke == nil
        render json: { error: "Pokemon not found" }, status: :not_found
    else
        return @poke  
    end
  end

end
