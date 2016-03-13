module V1
  class PlaylistsController < ApplicationController
    before_filter :set_user
    before_filter :set_playlist, only: [:show, :update, :destroy]

    # GET /v1/users/:user_id/playlists
    # Get all user playlists
    def index
      paginate json: @user.playlists.all
    end

    # GET /v1/users/:user_id/playlists/:id
    # Get a specific playlist
    def show
      render json: @playlist
    end

    # POST /v1/users/:user_id/playlists
    # Add a playlist
    def create
      @playlist = @user.playlists.new(playlist_params)
      if @playlist.save
        render json: @playlist
      else
        render json: { error: @playlist.errors }, status: :unprocessable_entity
      end
    end

    # PATCH /v1/users/:user_id/playlists/:id
    # Update playlist
    def update
      if @playlist.update(playlist_params)
        render json: @playlist
      else
        render json: { error: @playlist.errors }, status: :unprocessable_entity
      end
    end

    # DELETE /v1/users/:user_id/playlists/:id
    # Deletes a specific playlist
    def destroy
      @playlist.destroy
      render json: { message: I18n.t('playlist.destroy') }
    end

    private

    def playlist_params
      params.require(:playlist).permit(:name)
    end

    def set_playlist
      @playlist = @user.playlists.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end