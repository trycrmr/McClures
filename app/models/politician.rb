class Politician < ActiveRecord::Base

	validates :bioguide_id, presence: true, uniqueness: true	
end
