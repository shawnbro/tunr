# shared_playlist.rb
class SharedPlaylist < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :user

  validates :playlist, :user, presence: true
  validate :playlist_belongs_to_correct_user

  private

  def playlist_belongs_to_correct_user
    return unless playlist && user
    unless playlist.user == user
      errors.add(:user, "This playlist was not shared with you.")
    end
  end
end