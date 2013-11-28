class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user! 
  def checked_user
  	if not current_user.admin?
  		render "public/403.html"
  	end 
  end
end
