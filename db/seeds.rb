# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# Create users
  @admin = User.create(email: 'admin@rails_api.com', password: 'test1234', user_type: 0) #base 64 is YWRtaW5AcmFpbHNfYXBpLmNvbTp0ZXN0MTIzNA==
  @user = User.create(email: 'user@rails_api.com', password: 'test1234', user_type: 1)  #base 64 is dXNlckByYWlsc19hcGkuY29tOnRlc3QxMjM0
  @guest = User.create(email: 'guest@rails_api.com', password: 'test1234', user_type: 2) #base 64 is Z3Vlc3RAcmFpbHNfYXBpLmNvbTp0ZXN0MTIzNA==

# Create user playlidts
  @playlis1 = Playlist.create(name: 'Playlist 1', user: @admin)
  @playlis2 = Playlist.create(name: 'Playlist 1', user: @user)
  @playlis3 = Playlist.create(name: 'Playlist 1', user: @user)
  @playlis4 = Playlist.create(name: 'Playlist 1', user: @user)
