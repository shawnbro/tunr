class ChangeSharedPlaylists < ActiveRecord::Migration
  def change
    change_table(:shared_playlists) do |t|
      t.integer :shared_user
    end
  end
end
