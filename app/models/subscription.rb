class Subscription < ApplicationRecord
	# belongs_to :creator, class_name: 'User',foreign_key: 'creator_id', required: true

	belongs_to :package
	belongs_to :user

	enum status: [:requested, :success]
end
