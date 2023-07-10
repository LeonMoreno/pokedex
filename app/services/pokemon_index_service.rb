=begin
    To replace the hash with serializer
    https://medium.com/@maxfpowell/a-quick-intro-to-rails-serializers-b390ced1fce7
    * Note that, if you want to render a collection of resources,
     you need to use each_serializer: instead of serializer:. 

        rails g serializer Pokemon

        # Remplazado con serializer
        # pokeList = Hash.new
        # # puts "por el ELSE me fui"
        # pokemon.each do |u|
        #     pokeList[u.name] = {
        #         name: u.name,
        #         id: u.id
        #     }
        # end

    problems with url_helpers
    https://api.rubyonrails.org/v5.1/classes/ActionDispatch/Routing/UrlFor.html
=end

include Rails.application.routes.url_helpers

class PokemonIndexService
    def self.res(pokemon, numPokes)
    
        res = {
            all_count_pokes: numPokes,
            total_pages: pokemon.total_pages,
            current_page: pokemon.current_page
        }
        res[:next_page] = url_for(controller: 'pokemon', action: 'index',
            page: pokemon.next_page, only_path: true) if pokemon.next_page
        res[:list_pokemons] = ActiveModelSerializers::SerializableResource.new(pokemon, each_serializer: PokemonSerializer)
        return res
    end
end