class WelcomeController < ApplicationController
  skip_before_filter :authenticate_user_with_basic_auth!
  def index
    render :text => t('welcome')
  end
end
