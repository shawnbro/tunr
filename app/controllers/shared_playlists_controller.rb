# shared_playlists_controller.rb

class SharedPlaylistsController < ApplicationController

  def new
    @shared_playlist = SharedPlaylist.new
    @playlist = Playlist.find_by(params[:id])
    @users = User.all
  end

  def create
    @user = User.find_by(params[:user_id])
    @shared_playlist = SharedPlaylist.find_by(id: params[:shared_playlist])
    redirect_to shared_playlist_path(@shared_playlist.user_id)
  end 
end
    