require 'rest-client'
require 'json'
require 'pp'

class SearchController < ApplicationController
  def index

  end
  
  def new
  	@users_submitted_zip_code = params[:user_zip_code]
  	@search_results = API_Politician.get_array_of_politicians_from_SF_Congress_API_call("/legislators/locate", zip: @users_submitted_zip_code)
  	@message_no_search_results = "Your search did not return any results."
  end

end
