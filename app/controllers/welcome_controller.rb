# encoding: utf-8
class WelcomeController < ApplicationController
	#GET
	def dashboard
		render "welcome/dashboard"
	end
	def index
	end
end