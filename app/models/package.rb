class Package < ApplicationRecord
	# belongs_to :creator, class_name: 'User',foreign_key: 'creator_id', required: true
	has_many :subscription

end
