class Subscription < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :user

  validates_presence_of :playlist_id
  validates :playlist_id, uniqueness: { scope: :user_id,  message: I18n.t('subscription.already_subscribed') }
  validate :self_subscribe, unless: Proc.new { |sub| sub.playlist.nil? }

  def self_subscribe
    errors.add(:playlist, I18n.t('subscription.self_subscribe')) if playlist.user_id == user_id
  end
end
