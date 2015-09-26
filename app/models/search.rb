class Search < ActiveRecord::Base
	# http://api.rubyonrails.org/classes/ActiveRecord/Base.html => Saving arrays, hashes, and other non-mappable objects in text columns
	serialize :parameters, Hash
	belongs_to :user

	validates :user, presence: true	
end
