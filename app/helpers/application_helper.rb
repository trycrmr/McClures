module ApplicationHelper

	def party_name_from_initial party_initial
		case party_initial
			when "R"
			 "Republican"
			when "D"
			 "Democrat"
			when "I"
			 "Independent"
			else
			 "No party affiliation"
		end		
	end

	def foo(test)
		test
	end

end
