module V1
  class UsersController < ApplicationController
    before_filter :set_user, only: [:show, :update, :destroy]

    # GET /v1/users
    # Get all users
    def index
      paginate json: User.all
    end

    # GET /v1/users:id
    # Get a specific location
    def show
      render json: @user
    end

    # POST /v1/users
    # Add a new user
    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user
      else
        render json: { error: @user.errors }, status: :unprocessable_entity
      end
    end

    # PATCH /v1/users/:id
    # Update user
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: { error: @user.errors }, status: :unprocessable_entity
      end
    end

    # DELETE /v1/users/:id
    # Deletes a specific user
    def destroy
      @user.destroy
      render json: { message: I18n.t('user.destroy') }
    end

    def check_authorized_resource
      @assignments = Deliverable.find(params[:deliverable_id]).assignments
    end

    private

    def user_params
      if current_user.admin?
        params.require(:user).permit(:email, :password, :user_type)
      else
        params.require(:user).permit(:email, :password)
      end
    end

    def set_user
      @user = User.find(params[:id])
    end
  end
end