class SubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :playlist_id
end
