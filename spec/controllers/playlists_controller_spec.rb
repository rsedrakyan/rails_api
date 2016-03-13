require 'rails_helper'

describe V1::PlaylistsController do
  include Requests::JsonHelpers
  include Requests::AuthHelper

  before do
    @admin_user = create :user, user_type: 0
    @user = create :user, user_type: 1
    @guest_user = create :user, user_type: 2
    @playlist1, @playlist2, @playlist3 = create_list :playlist, 3, user: @user
    @playlist4 = create :playlist, user: @admin_user

    set_basic_auth_headers(@user.email, @user.password)
  end

  context 'GET index' do
    before do
      get :index, user_id: @user.id, page: 1, per_page: 2
    end

    it 'is successfull' do
      expect(response).to be_success
    end

    it 'loads playlists with pagination' do
      expect(json.count).to eq(2)
    end
  end

  context 'GET show' do
    before do
      get :show, user_id: @admin_user.id, id: @playlist4.id
    end

    it 'is successfull' do
      expect(response).to be_success
    end

    it 'shows particular playlist' do
      expect(json['id']).to eq(@playlist4.id)
    end
  end

  context 'POST create' do
    subject do
      post :create, user_id: @user.id, playlist: { name: 'new playlist' }
    end

    it 'creates new playlist' do
      expect{subject}.to change{Playlist.count}.by(1)
    end
  end

  context 'PATCH update' do
    subject do
      patch :update, user_id: @user.id, id: @playlist1.id, playlist: { name: 'another name' }
    end

    it 'updates playlist' do
      expect{subject}.to change{@playlist1.reload.name}.to('another name')
    end
  end

  context 'DELETE destroy' do
    subject do
      delete :destroy, user_id: @user.id, id: @playlist3.id
    end

    it 'deletes playlist' do
      expect{subject}.to change{Playlist.count}.by(-1)
    end
  end
end
