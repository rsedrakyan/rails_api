class TrackSerializer < ActiveModel::Serializer
  attributes :id, :name, :author, :album, :gener, :url
end
