class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :tracks, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :user
end
