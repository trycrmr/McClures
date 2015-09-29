class SearchController < ApplicationController
  def index

  end
  
  def new
  	@recent_searches = Search.last(5).reverse
    @recent_search_text = []
    @a_recent_searchs_text = ''
    @recent_searches.each do |search|
      search.parameters.each do |key, value|
        unless ["commit", "action", "controller", "utf8"].include? key
          @recent_search_text.push("#{key.humanize.titleize} #{value}")
          #present
        end
      end
    end
    puts @recent_search_text
    @this_users_recent_searches = user_signed_in? ? Search.where(user_id: current_user.id).last(5).reverse : nil

  	@users_submitted_zip_code = params[:zip_code]
  	@search_results = API_Politician.get_array_of_politicians_from_SF_Congress_API_call("search legislators by location", zip: @users_submitted_zip_code)
  	#IF THE SEARCH IS SUCCESSFUL WRITE THE SEARCH TO THE DATABASE AND SAVE THE POLITICIANS TO THE DATABASE IF THEY ARE NOT ALREADY SAVED TO THE DATABASE
  	 unless @search_results.empty?
  	 	#WRITE THIS SEARCH TO THE DATABASE
  	 	this_user_id = user_signed_in? ? current_user.id : nil
			this_search = Search.new
			this_search.user_id = this_user_id
			this_search.parameters = params
			this_search.save

			#IF THE POLITICIAN DOES NOT EXIST IN THE DATABASE YET ADD IT TO THE DATABASE WITH IT'S BIOGUIDE ID
			@search_results.each do |this_result|
				Politician.find_or_create_by(bioguide_id: this_result.bioguide_id)
			end
  	 end

  	@message_no_search_results = "Your search did not return any results."
  end

# private
#   def search_params
#     params.require(:story).permit(:title, :link, :upvotes, :category)
#   end  

end
