require 'rails_helper'

describe V1::UsersController do
  include Requests::JsonHelpers
  include Requests::AuthHelper

  before do
    @admin_user = create :user, user_type: 0
    @user = create :user, user_type: 1
    @guest_user = create :user, user_type: 2

    set_basic_auth_headers(@user.email, @user.password)
  end

  context 'GET index' do
    before do
      get :index, {page: 1, per_page: 2}
    end

    it 'is successfull' do
      expect(response).to be_success
    end

    it 'loads users with pagination' do
      expect(json.count).to eq(2)
    end
  end

  context 'GET show' do
    before do
      get :show, id: @guest_user.id
    end

    it 'is successfull' do
      expect(response).to be_success
    end

    it 'shows particular user' do
      expect(json['id']).to eq(@guest_user.id)
    end
  end

  context 'POST create' do
    subject do
      post :create, user: attributes_for(:user).merge(email: 'new_user@email.com', password: 'test1234', user_type: 0)
    end

    it 'creates new user' do
      expect{subject}.to change{User.count}.by(1)
    end

    it 'does not allow to create admin user with non admin user' do
      expect(User.last.user_type).to eq('guest')
    end
  end

  context 'PATCH update' do
    subject do
      patch :update, id: @user.id, user: { email: 'another_email@email.com', user_type: 0 }
    end

    it 'updates user' do
      expect{subject}.to change{@user.reload.email}.to('another_email@email.com')
    end

    it 'does not allow to change user role with non admin user' do
      expect(@user.reload.user_type).to eq('user')
    end
  end

  context 'DELETE destroy with non admin' do
    subject do
      delete :destroy, id: @guest_user.id
    end

    it 'should not delete user' do
      expect{subject}.to_not change{User.count}.from(3)
    end
  end

  context 'DELETE destroy with admin' do
    before do
      set_basic_auth_headers(@admin_user.email, @admin_user.password)
    end

    subject do
      delete :destroy, id: @guest_user.id
    end

    it 'deletes the user' do
      expect{subject}.to change{User.count}.by(-1)
    end
  end
end
