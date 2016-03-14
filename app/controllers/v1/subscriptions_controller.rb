module V1
  class SubscriptionsController < ApplicationController
    before_filter :set_user
    before_filter :set_subscription, only: [:show, :destroy]

    # GET /v1/users/:user_id/subscriptions
    # Get all user subscriptions
    def index
      paginate json: @user.subscriptions.all
    end

    # GET /v1/users/:user_id/subscriptions/:id
    # Get a specific subscription
    def show
      render json: @subscription
    end

    # POST /v1/users/:user_id/subscriptions
    # Add a subscription
    def create
      @subscription = @user.subscriptions.new(subscription_params)
      if @subscription.save
        render json: @subscription
      else
        render json: { error: @subscription.errors }, status: :unprocessable_entity
      end
    end

    # DELETE /v1/users/:user_id/subscriptions/:id
    # Deletes a specific subscription
    def destroy
      @subscription.destroy
      render json: { message: I18n.t('subscription.destroy') }
    end

    private

    def subscription_params
      params.require(:subscription).permit(:playlist_id)
    end

    def set_subscription
      @subscription = @user.subscriptions.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end