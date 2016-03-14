require 'rails_helper'

describe V1::TracksController do
  include Requests::JsonHelpers
  include Requests::AuthHelper

  before do
    @admin_user = create :user, user_type: 0
    @user = create :user, user_type: 1
    @playlist1 = create :playlist, user: @user
    @playlist2 = create :playlist, user: @admin_user
    @track1, @track2, @track3 = create_list :track, 3, playlist: @playlist1
    @track4 = create :track, playlist: @playlist2

    set_basic_auth_headers(@user.email, @user.password)
  end

  context 'GET index' do
    before do
      get :index, playlist_id: @playlist1.id, page: 1, per_page: 2
    end

    it 'is successfull' do
      expect(response).to be_success
    end

    it 'loads tracks with pagination' do
      expect(json.count).to eq(2)
    end
  end

  context 'GET show' do
    before do
      get :show, playlist_id: @playlist2.id, id: @track4.id
    end

    it 'is successfull' do
      expect(response).to be_success
    end

    it 'shows particular track' do
      expect(json['id']).to eq(@track4.id)
    end
  end

  context 'POST create' do
    subject do
      post :create, playlist_id: @playlist1.id, track: { name: 'new playlist', author: 'new author', 'url': 'new_url' }
    end

    it 'creates new track' do
      expect{subject}.to change{Track.count}.by(1)
    end
  end

  context 'PATCH update' do
    subject do
      patch :update, playlist_id: @playlist1.id, id: @track2.id, track: { name: 'another name' }
    end

    it 'updates track' do
      expect{subject}.to change{@track2.reload.name}.to('another name')
    end
  end

  context 'DELETE destroy' do
    subject do
      delete :destroy, playlist_id: @playlist1.id, id: @track2.id
    end

    it 'deletes track' do
      expect{subject}.to change{Track.count}.by(-1)
    end
  end
end
