class CreateSharedPlaylist < ActiveRecord::Migration
  def change
    create_table :shared_playlists do |t|
      t.references :playlist
      t.references :user
    end
  end
end
