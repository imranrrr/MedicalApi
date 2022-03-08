class AddDeleteTemporaryToDirectory < ActiveRecord::Migration[6.0]
  def change
  	add_column :directories, :delete_temporary, :boolean, default: :false
  end
end
