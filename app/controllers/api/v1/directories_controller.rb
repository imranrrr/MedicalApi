class Api::V1::DirectoriesController < ApplicationController
	before_action :authenticate_user!

	before_action :set_directory, only: [:show, :update, :destroy, :delete_temporary, :move_from_trash, :shared_directory, :upload_file]

  # GET /directories
  def index
    @directories = current_user.directories.where(delete_temporary: false)

    render json: @directories
  end

  # GET /directories/1
  def show
    render json: @directory
  end

  # POST /directories
  def create
  	directory = current_user.directories.new(directory_params)

    if directory.save!
    	user_directory_connections = UserDirectoryConnection.new(user_id: current_user.id, directory_id: directory.id)
		user_directory_connections.save!
    	directories = current_user.directories.where(delete_temporary: false)
      	render_success({directories: directories})
    else
      render_failure(directory.errors)
    end
  end

  # PATCH/PUT /directories/1
  def update
    if @directory.update(directory_params)
    	@directories = current_user.directories.where(delete_temporary: false)
      	render_success({directories: @directories})
    else
      render_failure(@directory.errors)
    end
  end

  # DELETE /directories/1
  def destroy
  	if @directory.destroy
    	@directories = current_user.directories.where(delete_temporary: true)
      	render_success({directories: @directories})
    else
      render_failure(@directory.errors)
    end
  end

  def delete_temporary
  	if @directory.update(delete_temporary: params[:delete_temporary])
    	@directories = current_user.directories.where(delete_temporary: false)
      	render_success({directories: @directories})
    else
      render_failure(@directory.errors)
    end
  end

  def delete_temporary_directories
  	 @directories = current_user.directories.where(delete_temporary: true)

    render json: @directories
  end

  def move_from_trash
  	if @directory.update(delete_temporary: params[:delete_temporary])
    	@directories = current_user.directories.where(delete_temporary: true)
      	render_success({directories: @directories})
    else
      render_failure(@directory.errors)
    end
  end

  def user_list 
  	@users = User.all
    render json: @users
  end

  def shared_directory
  	 user_list = params["optionsSelected"]
  	 user_list.each do |user|
  	 	user_directory_connections = UserDirectoryConnection.new(user_id: user['id'], directory_id: @directory.id)
  	 	user_directory_connections.save!
  	 end
  end

  def upload_file
  	@directory
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_directory
      @directory = Directory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def directory_params
      params.require(:directory).permit(:name)
    end
end