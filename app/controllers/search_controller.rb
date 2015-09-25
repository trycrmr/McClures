require 'rest-client'
require 'json'
require 'pp'

class SearchController < ApplicationController
  def index
  	# @users_submitted_zip_code = params[:user_zip_code]
  	# @user_parameters = {"zip_code" => "#{@users_submitted_zip_code}"}
  	# @api_key = ENV['API_KEY_SUNLIGHTFOUNDATION']
  	# @api_key_url_string = "?apikey=#{@api_key}"
  	# @api_call = RestClient.get(build_api_call_for_Sunlight_Foundation(@user_parameters, @api_key_url_string))
  	# @api_call_result = JSON.load(@api_call)
  	# if !@api_call_result["results"].empty?
  	# 	@congressman = "#{@api_call_result["results"][0]["first_name"]} #{@api_call_result["results"][0]["last_name"]}"
  	# else
  	# 	@api_error = "API call failed"
  	# 	puts @api_error
  	# end
  end
  
  def new
  	@users_submitted_zip_code = params[:user_zip_code]
  	@search_results = API_Politician.get_array_of_politicians_from_SF_Congress_API_call("/legislators/locate", zip: @users_submitted_zip_code)
  	@message_no_search_results = "Your search did not return any results."
  	# @users_submitted_zip_code = params[:user_zip_code]
  	# @user_parameters = {"zip_code" => "#{@users_submitted_zip_code}"}
  	# @api_key = ENV['API_KEY_SUNLIGHTFOUNDATION']
  	# @api_key_url_string = "?apikey=#{@api_key}"
  	# @api_call = RestClient.get(build_api_call_for_Sunlight_Foundation(@user_parameters, @api_key_url_string))
  	# @api_call_result = JSON.load(@api_call)
  	# if !@api_call_result["results"].empty?
  	# 	@congressman = "#{@api_call_result["results"][0]["first_name"]} #{@api_call_result["results"][0]["last_name"]}"
  	# else
  	# 	@api_error = "API call failed"
  	# 	puts @api_error
  	# end
  end

  # def create
  #   @shirt = Shirt.new safe_shirt_params
  #   if @shirt.save
  #     redirect_to shirt_path(@shirt)
  #   else
  #     flash_first_error(@shirt)
  #     redirect_to new_shirt_path
  #   end
  # end

  # def show
  #   @shirt = Shirt.find(params[:id])

  # end  
end

	def build_api_call_for_Sunlight_Foundation(user_parameters, api_key)
		#The basic endpoint of the Sunlight Foundation api
		@api_rest_endpoint = "https://congress.api.sunlightfoundation.com"

		#The possible methods which can be passed to the Sunlight Foundation api
		@api_methods = [{"path": "/legislators", desc: "Current legislators’ names, IDs, biography, and social media."},
			{"path": "/documents/search", desc: "Oversight documents including Government Accountability Office reports and Inspectors General reports."},
			{"path": "/committees", desc: "Current committees, subcommittees, and their membership."},
			{"path": "/bills", desc: "Legislation in the House and Senate, back to 2009. Updated daily."},
			{"path": "/bills/search", desc: "Full text search over legislation."},
			{"path": "/amendments", desc: "Amendments in the House and Senate, back to 2009. Updated daily."},
			{"path": "/nominations", desc: "Presidential nominations before the Senate, back to 2009. Updated daily."},
			{"path": "/votes", desc: "Roll call votes in Congress, back to 2009. Updated within minutes of votes."},
			{"path": "/floor_updates", desc: "To-the-minute updates from the floor of the House and Senate."},
			{"path": "/hearings", desc: "Committee hearings in Congress. Updated as hearings are announced."},
			{"path": "/upcoming_bills", desc: "Bills scheduled for debate in the future, as announced by party leadership."},
			{"path": "/congressional_documents/search", desc: "Congressional documents including House witness documents and House committee reports."},
			{"path": "/districts/locate", desc: "Find congressional districts for a latitude/longitude or zip."},
			{"path": "/legislators/locate", desc: "Find representatives and senators for a latitude/longitude or zip."}]

			if @user_parameters['zip_code']
				@this_users_zip_code = @user_parameters['zip_code']
				@zip_code_url_string = '&zip=' + @this_users_zip_code
			end

			url_rest_endpoint = @api_rest_endpoint + @api_methods[13][:path] + api_key + @zip_code_url_string
			puts url_rest_endpoint
			url_rest_endpoint
	end


	#Pass a zip code and receive the congressman for that zip code
	def find_congressman_by_zip_code(a_users_zip_code)
		#Format the zip code so it can be plugged into a URL
		api_param_zip_code = "&zip=#{a_users_zip_code}"

		#Create url
		url_rest_endpoint = @api_rest_endpoint + @api_methods[13][:path] + @api_key + api_param_zip_code

		#Make the call to the REST client and format it in JSON
		data = RestClient.get(url_rest_endpoint)
		result = JSON.load(data)

		#If the resulting JSON's length is less than two then Sunlight Foundation did not return any information associated with that zip code
		if result["results"].empty?
			#A Congressman could not be identified for the zip code provided
			"No Congressman for that zip code."
		else
			#Procure the name of the congressman from the JSON
			congressman = "#{result["results"][0]["first_name"]} #{result["results"][0]["last_name"]}"

			#Return the Congressman's name
			congressman			
		end

	end