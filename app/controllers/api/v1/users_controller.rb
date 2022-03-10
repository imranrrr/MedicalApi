class Api::V1::UsersController < ApplicationController
	before_action :authenticate_user!

	def attachments
		urls = current_user.files.map{|file| ({id: file.id, url: rails_blob_path(file), file_name: file.blob.filename}) }
		render_success({attachments: urls})
	end

	def upload_file
		if params[:file].present?
		   current_user.update(files: [params[:file]])
	       render_success
      	end
	end 



end