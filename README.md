# rails_api

This API is a playlist sharing tool. Users can create playlists, add tracks to them and subscribe to
playlists of other people.


###Steps to Run Locally

Here are the complete steps to set up and run the Rails API locally.

1. new terminal tab: bundle install
2. `rake db:drop db:create db:migrate db:seed` then `rails s`
3. Open your favorite API testing tool
4. Use HTTP basic authentication to send requests