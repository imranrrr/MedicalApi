class Api::V1::UsersController < ApplicationController
	before_action :authenticate_user!

	def upload_file
		byebug
		current_user.files.attach(params[:file])

	end 


	private

	def user_params
	  params.permit(:file)
	end 


end