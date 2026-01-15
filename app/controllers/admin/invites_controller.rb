class Admin::InvitesController < ApplicationController

	def index
		@roles = Sys::Role.all
		@invites = Sys::InviteCode.all
	end
end
