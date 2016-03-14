# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# Create users
  @admin = User.create(email: 'admin@rails_api.com', password: 'test1234', user_type: 0) #base 64 is YWRtaW5AcmFpbHNfYXBpLmNvbTp0ZXN0MTIzNA==
  @user = User.create(email: 'user@rails_api.com', password: 'test1234', user_type: 1)  #base 64 is dXNlckByYWlsc19hcGkuY29tOnRlc3QxMjM0
  @guest = User.create(email: 'guest@rails_api.com', password: 'test1234', user_type: 2) #base 64 is Z3Vlc3RAcmFpbHNfYXBpLmNvbTp0ZXN0MTIzNA==

# Create user playlists
  @playlist1 = Playlist.create(name: 'Playlist 1', user: @admin)
  @playlist2 = Playlist.create(name: 'Playlist 2', user: @user)
  @playlist3 = Playlist.create(name: 'Playlist 3', user: @user)
  @playlis14 = Playlist.create(name: 'Playlist 4', user: @user)

# Create playlist tracks
  @track1 = Track.create(name: 'Playlist 1', author: 'Author 1', album: 'Album 1', gener: 'gener 1', url: 'http://track.site.com/track_path', playlist: @playlist2)
  @track2 = Track.create(name: 'Playlist 2', author: 'Author 2', album: 'Album 3', gener: 'gener 2', url: 'http://track.site.com/track_path', playlist: @playlist2)
  @track3 = Track.create(name: 'Playlist 3', author: 'Author 1', album: 'Album 1', gener: 'gener 1', url: 'http://track.site.com/track_path', playlist: @playlist2)
