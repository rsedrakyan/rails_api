class Track < ActiveRecord::Base
  belongs_to :playlist

  validates_presence_of :name, :author, :url
  validates :name, uniqueness: { scope: [:playlist_id, :author] }
  
  def user_id
    playlist.user_id
  end
end
