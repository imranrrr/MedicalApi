class DirectorySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :username, :created_at

  attribute :created_date do |user|
    user.created_at && user.created_at.strftime('%d/%m/%Y')
  end
end