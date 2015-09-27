class Favorite < ActiveRecord::Base

	validates :user_id, presence: true	
	validates :politician_id, presence: true
	# validates :id, :uniqueness, true		
end
