# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
 User.create(email: 'admin@rails_api.com', password: 'test1234', user_type: 0) #base 64 is YWRtaW5AcmFpbHNfYXBpLmNvbTp0ZXN0MTIzNA==
 User.create(email: 'user@rails_api.com', password: 'test1234', user_type: 1)  #base 64 is dXNlckByYWlsc19hcGkuY29tOnRlc3QxMjM0
 User.create(email: 'guest@rails_api.com', password: 'test1234', user_type: 2) #base 64 is Z3Vlc3RAcmFpbHNfYXBpLmNvbTp0ZXN0MTIzNA==
