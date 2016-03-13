require 'rails_helper'

describe Playlist do
  before do
    @user1, @user2 = create_list :user, 2
    create :playlist, name: 'Playlist 1', user: @user1
  end

  it 'validates name uniqueness with user scope' do
    expect(Playlist.new(name: 'Playlist 1', user: @user1)).to_not be_valid
    expect(Playlist.new(name: 'Playlist 1', user: @user2)).to be_valid
  end

end