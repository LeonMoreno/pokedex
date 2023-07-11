class PokemonParams
    def self.create(params)
        params.require(:pokemon).permit(:name, :type_1, :total, :hp, :attack,
            :defense, :sp_atk, :sp_def, :speed, :generation, :legendary)
    end

    def self.update(params)
      params.require(:pokemon).permit(:name, :total, :hp, :attack, :defense, :sp_atk, :sp_def, :speed)
    end
end