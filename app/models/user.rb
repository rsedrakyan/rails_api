class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :playlists, dependent: :destroy
  has_many :subscriptions, dependent: :destroy


  enum user_type: Constants::USER_TYPE

  alias_attribute :user_id, :id

  def admin?
    user_type == 'admin'
  end

  def guest?
    user_type == 'guest'
  end
end
