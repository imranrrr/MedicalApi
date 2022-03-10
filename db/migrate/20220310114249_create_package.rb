class CreatePackage < ActiveRecord::Migration[6.0]
  def change
    create_table :packages do |t|
      t.string :name
      t.integer :price
    end
  end
end
