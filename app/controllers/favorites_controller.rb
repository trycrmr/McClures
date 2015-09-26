class FavoritesController < ApplicationController
	before_action :authenticate_user!

  def index
  end

  def create
  	@this_user_id = current_user.id
  	puts @this_user_id
  	@this_politician = params.has_key?(:bioguide_id) ? params[:bioguide_id] : nil
  	@this_politician_id = @this_politician ? Politician.find_by(bioguide_id: @this_politician).id : nil
  	@this_favorite = Favorite.create(user_id: @this_user_id, politician_id: @this_politician_id)
  end
end
