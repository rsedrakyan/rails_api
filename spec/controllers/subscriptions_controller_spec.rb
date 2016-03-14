require 'rails_helper'

describe V1::SubscriptionsController do
  include Requests::JsonHelpers
  include Requests::AuthHelper

  before do
    @admin_user = create :user, user_type: 0
    @user = create :user, user_type: 1
    @playlist1, @playlist2, @playlist3 = create_list :playlist, 3, user: @user
    @playlist4 = create :playlist, user: @admin_user
    @sub1 = create :subscription, user: @admin_user, playlist: @playlist1
    @sub2 = create :subscription, user: @admin_user, playlist: @playlist2
    @sub3 = create :subscription, user: @admin_user, playlist: @playlist3

    set_basic_auth_headers(@admin_user.email, @admin_user.password)
  end

  context 'GET index' do
    before do
      get :index, user_id: @admin_user.id, page: 1, per_page: 2
    end

    it 'is successfull' do
      expect(response).to be_success
    end

    it 'loads subscriptions with pagination' do
      expect(json.count).to eq(2)
    end
  end

  context 'GET show' do
    before do
      get :show, user_id: @admin_user.id, id: @sub1.id
    end

    it 'is successfull' do
      expect(response).to be_success
    end

    it 'shows particular playlist' do
      expect(json['id']).to eq(@sub1.id)
    end
  end

  context 'POST create' do
    before do
      set_basic_auth_headers(@user.email, @user.password)
    end

    subject do
      post :create, user_id: @user.id, subscription: { playlist_id: @playlist4.id }
    end

    it 'creates new playlist' do
      expect{subject}.to change{Subscription.count}.by(1)
    end
  end

  context 'DELETE destroy' do
    subject do
      delete :destroy, user_id: @admin_user.id, id: @sub1.id
    end

    it 'deletes playlist' do
      expect{subject}.to change{Subscription.count}.by(-1)
    end
  end
end
