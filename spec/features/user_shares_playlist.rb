# user_shares_playlist.rb
require 'spec_helper'

#   1. Data Setup 
describe "a user shares a playlist" do 
  #create three users
    let(:user) do

      User.create!({
      email: "a@b.co",
      password: "shawn2",
      password_confirmation: "shawn2",
      first_name: "Brian",
      last_name: "C",
      dob: Date.today,
      balance: 100.00
    }) 

    User.create!({
      email: "s@d.co",
      password: "shawn1",
      password_confirmation: "shawn1",
      first_name: "Shawn",
      last_name: "B",
      dob: Date.today,
      balance: 100.00
    }) 

    User.create!({
      email: "e@f.co",
      password: "shawn3",
      password_confirmation: "shawn3",
      first_name: "Charlie",
      last_name: "D",
      dob: Date.today,
      balance: 100.00
    }) 
  end


  # let(:unshared_user) do 

  # end

  #create a playlist

  let(:playlist) do 
    Playlist.create!({
      title: "New Playlist",
      user_id: user.id
      })
  end

  it "can share a playlist with another user" do 
    #Setup
    # Log in as the creator
    login(user)
    #workflow for feature
    # Add user_2 as shared
    visit playlist_path(playlist)
    click_link("Share Playlist")
     save_and_open_page
     

    select "Brian", from: "User"
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
    login(shared_user)
    # Visit playlist
    visit playlist_path(playlist)
    # 9.  Expect can see it
    within ".playlist" do 
      expect(page).to have_content "New Playlist"
    end
    # 10.  Log out 
    logout(shared_user)
    # 11.  Log in as not shared user
    login(unshared_user)
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
