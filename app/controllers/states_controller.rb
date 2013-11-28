class StatesController < ApplicationController
	
	def cities
		@state = State.find_by_id (params[:id])
		@cities = City.order("name").where ("state_id = #{@state.id}")

		options = ""
		@cities.each do |city|
			options += "<option value=\"#{city.id}\" > #{city.name}</option>"
		end
		render text: options
	end

end