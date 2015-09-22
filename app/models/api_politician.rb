class API_Politician

	def self.fid
		"H8NY24066"
	end

	def self.get_api_info_using_fec_id(a_fec_id)
		# puts info_a
    # hit api for politian info
 		api_rest_endpoint = "https://congress.api.sunlightfoundation.com/legislators"
  	api_key = ENV['API_KEY_SUNLIGHTFOUNDATION']
  	api_key_url_string = "?apikey=#{api_key}"
  	puts api_key_url_string
  	a_fed_ids_url_string = "&fec_ids=#{a_fec_id}"
  	url_for_api_call = "#{api_rest_endpoint}#{api_key_url_string}#{a_fed_ids_url_string}"
  	puts url_for_api_call
  	api_call = RestClient.get(url_for_api_call)
    # take json data make sure I have array of politians
    api_call_in_json = JSON.load(api_call)
#     politicians.map do |politician|
#       API_Politician.new(politician)
#     end
		API_Politician.new(api_call_in_json)
	end

  def initialize(some_info)
    @info = some_info
    puts @info
  end

end

# class Politician
#   def self.get_by_ids(p_ids)
#     #hit api for politian info
#     #take json data make sure I have array of politians
#     politicians.map do |politician|
#       Politian.new(politician)
#     end
#   end

#   def initialize(info)
#     @info = info
#   end

#   def method_missing(method_name, *args)
#     if @info.keys.include? method_name.to_s
#       @info[method_name.to_s]
#     else
#       super
#     end
#   end
# end

# politician = Politician.new({'fec_id': 'theustehut', 'nickname': 'big guy'})

# politician.fec_id