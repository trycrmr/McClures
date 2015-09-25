class API_Politician

  API_CALLS_SUNLIGHT_FOUNDATION_CONGRESS = [{"nickname": "legislators", "path": "/legislators", desc: "Current legislators’ names, IDs, biography, and social media."},
    {"nickname": "oversight documents search", "path": "/documents/search", desc: "Oversight documents including Government Accountability Office reports and Inspectors General reports."},
    {"nickname": "committees", "path": "/committees", desc: "Current committees, subcommittees, and their membership."},
    {"nickname": "bills", "path": "/bills", desc: "Legislation in the House and Senate, back to 2009. Updated daily."},
    {"nickname": "bills search", "path": "/bills/search", desc: "Full text search over legislation."},
    {"nickname": "amendments", "path": "/amendments", desc: "Amendments in the House and Senate, back to 2009. Updated daily."},
    {"nickname": "nominations", "path": "/nominations", desc: "Presidential nominations before the Senate, back to 2009. Updated daily."},
    {"nickname": "votes", "path": "/votes", desc: "Roll call votes in Congress, back to 2009. Updated within minutes of votes."},
    {"nickname": "floor updates", "path": "/floor_updates", desc: "To-the-minute updates from the floor of the House and Senate."},
    {"nickname": "hearings", "path": "/hearings", desc: "Committee hearings in Congress. Updated as hearings are announced."},
    {"nickname": "upcoming bills", "path": "/upcoming_bills", desc: "Bills scheduled for debate in the future, as announced by party leadership."},
    {"nickname": "congressional documents search", "path": "/congressional_documents/search", desc: "Congressional documents including House witness documents and House committee reports."},
    {"nickname": "search congressional districts by location", "path": "/districts/locate", desc: "Find congressional districts for a latitude/longitude or zip."},
    {"nickname": "search legislators by location", "path": "/legislators/locate", desc: "Find representatives and senators for a latitude/longitude or zip."}]

    #GETS THE PATH FOR A SPECIFIC CALL TO THE CONGRESS API GIVEN THE NICKNAME FOR THAT CALL IN THE MCCLURES APP (DEFINED IN THE API_Politician::API_CALLS_SUNLIGHT_FOUNDATION_CONGRESS CONSTANT)
    def self.get_SF_Congress_API_call_path(nickname)
      the_api_method_path = ''
      API_Politician::API_CALLS_SUNLIGHT_FOUNDATION_CONGRESS.each do |an_api_method|

        if (an_api_method[:nickname] == nickname)
          the_api_method_path = an_api_method[:path]
        else
          #DO NOTHING
        end
      end
      the_api_method_path ? the_api_method_path : "No Sunlight Foundation Congress API path found for that nickname. See the API_Politician::API_CALLS_SUNLIGHT_FOUNDATION_CONGRESS constant for a hash of all options"
    end

  def self.get_array_of_politicians_from_SF_Congress_API_call(sf_congress_api_call_path, options={})
    {
      zip: options[:zip]
    }
    #^OPTIONS HASH KEYS SHOULD MATCH THE SUNLIGHT FOUNDATION CONGRESS API PARAMATERS

    # hit api for politian info
    api_rest_endpoint = "https://congress.api.sunlightfoundation.com#{sf_congress_api_call_path}"
    api_key = ENV['API_KEY_SUNLIGHTFOUNDATION']
    api_key_url_string = "?apikey=#{api_key}"

    #ITERATE THROUGH OPTIONS HASH AND APPEND TO api_key_url_string. THIS IS WHY THE OPTIONS HASH KEYS MUST MATCH THE SUNLIGHT FOUNDATION CONGRESS API PARAMETERS    
    url_params_string = ""    
    options.each do |key, value|
      url_params_string += "&#{key}=#{value.to_s}"
    end    

    url_for_api_call = "#{api_rest_endpoint}#{api_key_url_string}#{url_params_string}"
    puts url_for_api_call
    api_call = RestClient.get(url_for_api_call)

    # take json data make sure I have array of POLITICIANS
    api_call_in_json = JSON.load(api_call)

    #FOR EVERY PAGE RETURNED FROM THE API & EACH POLITICIAN
    array_of_politicians = []
    api_call_in_json["results"].each do |politician|
      this_politician = API_Politician.new(politician)
      array_of_politicians.push(this_politician)
    end

    array_of_politicians

  end

  #create politician(s) from API call

  def initialize(politician_info_json)
    @politician_info = politician_info_json
  end

  def method_missing(method_name, *args)
    if @politician_info.keys.include? method_name.to_s
      @politician_info[method_name.to_s]
    else
      super
    end
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