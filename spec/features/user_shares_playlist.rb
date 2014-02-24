# user_shares_playlist.rb
require 'spec_helper'

#   1. Data Setup 
describe "a user can share a playlist" do 
  #create three users
  let(:user) do 
    User.create!({
      email: "s@b.co",
      password: "shawn",
      password_confirmation: "shawn",
      first_name: "Shawn",
      last_name: "B",
      dob: Date.today,
      balance: 100.00
    }) 
  end
  let(:user_2) do 
      email: "a@b.co",
      password: "shawn",
      password_confirmation: "shawn",
      first_name: "Brian",
      last_name: "B",
      dob: Date.today,
      balance: 100.00
    }) 
  end
  let(:user_3) do 
      email: "c@d.co",
      password: "shawn",
      password_confirmation: "shawn",
      first_name: "Charlie",
      last_name: "B",
      dob: Date.today,
      balance: 100.00
    }) 
  end
  #create a playlist
  let(:playlist) do 
    Playlist.create!({
      title: "New Playlist"
      user_id: user.id
      })
  end

  it "shares a playlist with another user" do 
    #Setup
    # Log in as the creator
    login(user)

    #workflow for feature
    # Add user_2 as shared
    visit playlist_path(playlist)
    click_link "Share Playlist"
    select playlist.title, from: "playlists"
    select user_2, from: "users"
    click_button "Share"

    # Visit the playlist
    visit playlist_path(playlist)
    # Expect user can see it
    within ".playlist" do 
      expect(page).to have_content "New Playlist"
    end
    # Logout
    logout(user)
    # Login as shared user
    login(user_2)
    # Visit playlist
    visit playlist_path(playlist)
    # 9.  Expect can see it
    within ".playlist" do 
      expect(page).to have_content "New Playlist"
    end
    # 10.  Log out 
    logout(user_2)
    # 11.  Log in as not shared user
    login(user_3)
    # 12.  Visit playlist
    visit playlist_path(playlist)
    # 13.  expect they cannot see the playlist
    within ".playlist" do
      expect(page).to_not have_content "New Playlist"
    end
  end

  def login(user)
    visit "/login"
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Log in!"
  end
end
