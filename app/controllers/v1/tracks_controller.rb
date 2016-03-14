module V1
  class TracksController < ApplicationController
    before_filter :set_playlist
    before_filter :set_track, only: [:show, :update, :destroy]

    # GET /v1/playlists/:playlist_id/tracks
    # Get all playlist tracks
    def index
      paginate json: @playlist.tracks.all
    end

    # GET /v1/playlists/:playlist_id/track/:id
    # Get a specific track
    def show
      render json: @track
    end

    # POST /v1/playlists/:playlist_id/tracks
    # Add a track
    def create
      @track = @playlist.tracks.new(track_params)
      if @track.save
        render json: @track
      else
        render json: { error: @track.errors }, status: :unprocessable_entity
      end
    end

    # PATCH /v1/playlists/:playlist_id/tracks/:id
    # Update track
    def update
      if @track.update(track_params)
        render json: @track
      else
        render json: { error: @track.errors }, status: :unprocessable_entity
      end
    end

    # DELETE /v1/playlists/:playlist_id/tracks/:id
    # Deletes a specific track
    def destroy
      @track.destroy
      render json: { message: I18n.t('track.destroy') }
    end

    private

    def track_params
      params.require(:track).permit(:name, :author, :album, :gener, :url)
    end

    def set_playlist
      @playlist = Playlist.find(params[:playlist_id])
    end

    def set_track
      @track = @playlist.tracks.find(params[:id])
    end
  end
end