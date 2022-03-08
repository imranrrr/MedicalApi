class CreateUsersDirectories < ActiveRecord::Migration[6.0]
  def change
    create_table :user_directory_connections do |t|
    	t.belongs_to :user
    	t.belongs_to :directory

    	t.timestamps
    end
  end
end
