class Directory < ApplicationRecord
	# belongs_to :creator, class_name: 'User',foreign_key: 'creator_id', required: true
    has_many :user_directory_connections
    has_many :users, through: :user_directory_connections
    has_many_attached :files
end
