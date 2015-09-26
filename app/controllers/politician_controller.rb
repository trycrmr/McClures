class PoliticianController < ApplicationController
  def show
  	this_politicians_bioguide_id = params[:bioguide_id]
		@this_politician = API_Politician.get_array_of_politicians_from_SF_Congress_API_call("legislators", bioguide_id: this_politicians_bioguide_id).pop
  end
end
