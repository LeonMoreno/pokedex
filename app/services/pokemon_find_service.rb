class PokemonFindService
    def self.find(pokemon, search_value)
        if search_value.to_i != 0
            @poke = pokemon.find_by(id: search_value)
        else
            @poke = pokemon.find_by(name: search_value)
        end
    end
end
