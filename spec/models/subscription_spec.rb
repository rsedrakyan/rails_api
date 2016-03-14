require 'rails_helper'

describe Subscription do
  before do
    @user1, @user2 = create_list :user, 2
    @playlist = create :playlist, name: 'Playlist 1', user: @user1
  end

  it 'restricts double subscription' do
    Subscription.create(user: @user2, playlist: @playlist)
    expect(Subscription.new( user: @user2, playlist: @playlist)).to_not be_valid
  end

  it 'restricts self subscription' do
    expect(Subscription.new( user: @user1, playlist: @playlist)).to_not be_valid
  end

  it 'validates presence of playlist' do
    expect(Subscription.new(user: @user1)).to_not be_valid
  end

end