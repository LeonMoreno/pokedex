include Rails.application.routes.url_helpers

class PokemonIndexService
    def self.res(pokemon, numPokes)
        pokeList = Hash.new
        # puts "por el ELSE me fui"
        pokemon.each do |u|
            pokeList[u.name] = {
                name: u.name,
                id: u.id
            }
        end
        res = {
            all_count_pokes: numPokes,
            total_pages: pokemon.total_pages,
            current_page: pokemon.current_page
        }
        if pokemon.next_page
            next_page_url = pokemon_url(page: pokemon.next_page, only_path: true)
            res[:next_page] = next_page_url
        end
        res.merge!(pokeList)
    end
end