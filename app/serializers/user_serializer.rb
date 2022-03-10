class UserSerializer  < ActiveModel::Serializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email  
end
