class Admin::RolesController < ApplicationController

	def index
		@roles = Sys::Role.all
	end
end
