require 'rails_helper'

describe 'UserAuthorizationPolicy' do
  before do
    @admin_user = create :user, user_type: 0
    @user = create :user, user_type: 1
    @guest_user = create :user, user_type: 2
  end

  context 'user' do
    it 'can only read with guest role' do
      expect(UserAuthorizationPolicy.new(@guest_user, 'user', 'create').authorized?).to be false
      expect(UserAuthorizationPolicy.new(@guest_user, 'user', 'destroy', @user.id).authorized?).to be false
      expect(UserAuthorizationPolicy.new(@guest_user, 'user', 'update', @user.id).authorized?).to be false
      expect(UserAuthorizationPolicy.new(@guest_user, 'user', 'index').authorized?).to be true
      expect(UserAuthorizationPolicy.new(@guest_user, 'user', 'show', @user.id).authorized?).to be true
    end

    it "can create and only update and destroy his records with  'user' role" do
      expect(UserAuthorizationPolicy.new(@user, 'user', 'create').authorized?).to be true
      expect(UserAuthorizationPolicy.new(@user, 'user', 'destroy', @guest_user.id).authorized?).to be false
      expect(UserAuthorizationPolicy.new(@user, 'user', 'destroy', @user.id).authorized?).to be true
      expect(UserAuthorizationPolicy.new(@user, 'user', 'update', @guest_user.id).authorized?).to be false
      expect(UserAuthorizationPolicy.new(@user, 'user', 'update', @user.id).authorized?).to be true
    end

    it 'can do anything with admin role' do
      expect(UserAuthorizationPolicy.new(@admin_user, 'user', 'create').authorized?).to be true
      expect(UserAuthorizationPolicy.new(@admin_user, 'user', 'destroy', @user.id).authorized?).to be true
      expect(UserAuthorizationPolicy.new(@admin_user, 'user', 'update', @user.id).authorized?).to be true
      expect(UserAuthorizationPolicy.new(@admin_user, 'user', 'index').authorized?).to be true
      expect(UserAuthorizationPolicy.new(@admin_user, 'user', 'show', @user.id).authorized?).to be true
    end
  end
end
