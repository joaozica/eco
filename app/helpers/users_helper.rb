module UsersHelper
	def is_password_valid?(password)
		if @password.length < 6
			return false
		else
			return true
		end
	end

end
