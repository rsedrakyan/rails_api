require 'rails_helper'

describe Track do
  before do
    @user1 = create :user
    @playlist1, @playlis2 = create_list :playlist, 2
    create :track, name: 'Taken name', author: 'Same author', playlist: @playlist1
    create :track, name: 'Another name', author: 'Same author', playlist: @playlist2
  end

  it 'validates name uniqueness with playlist and author scope' do
    expect(Track.new(name: 'Taken name', author: 'Same author', playlist: @playlist1, url: 'some_url')).to_not be_valid
    expect(Track.new(name: 'Taken name', author: 'Another author', playlist: @playlist1, url: 'some_url')).to be_valid
    expect(Track.new(name: 'Another name', author: 'Same author', playlist: @playlist1, url: 'some_url')).to be_valid
  end

  it 'validates presence of name' do
    expect(Track.new(name: '', playlist: @playlist1, url: 'some_url')).to_not be_valid
  end

  it 'validates presence of author' do
    expect(Track.new(author: '', playlist: @playlist1, url: 'some_url')).to_not be_valid
  end

  it 'validates presence of url' do
    expect(Track.new(url: '', playlist: @playlist1)).to_not be_valid
  end
end
