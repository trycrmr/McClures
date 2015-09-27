class FavoritesController < ApplicationController
	before_action :authenticate_user!

  def index
    @this_user_id = current_user.id
    # @this_users_favorites = []
    @this_users_favorite_politicians = []    
    Favorite.find_each do |a_favorite|
      # @this_users_favorites.push(a_favorite)
      @this_politicians_bioguide_id = Politician.find_by(id: a_favorite.politician_id).bioguide_id
      puts @this_politicians_bioguide_id
      this_politician = API_Politician.get_array_of_politicians_from_SF_Congress_API_call("legislators", bioguide_id: @this_politicians_bioguide_id).pop
      @this_users_favorite_politicians.push(this_politician)
    end


  end

  def create
  	@this_user_id = current_user.id
  	puts @this_user_id
  	@this_politician = params.has_key?(:bioguide_id) ? params[:bioguide_id] : nil
  	@this_politician_id = @this_politician ? Politician.find_by(bioguide_id: @this_politician).id : nil
  	@this_favorite = Favorite.find_or_create_by(user_id: @this_user_id, politician_id: @this_politician_id)
    redirect_to favorites_index_path
  end
end
