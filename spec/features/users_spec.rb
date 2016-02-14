require 'rails_helper'

include Helpers

describe "User" do
  let!(:user) { FactoryGirl.create :user }
  let!(:beer) { FactoryGirl.create :beer }
  #let!(:rating) { FactoryGirl.create :rating }
  #let!(:rating2) { FactoryGirl.create :rating2 }

  before :each do

  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    sign_in(username:"Pekka", password:"Foobar1")

    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "has listed own ratings" do
    sign_in(username:"Pekka", password:"Foobar1")
    FactoryGirl.create(:rating)
    visit user_path(user)
    expect(page).to have_content '10'
  end
  it "can delete own rating" do
    sign_in(username:"Pekka", password:"Foobar1")
    FactoryGirl.create(:rating)
    visit user_path(user)
    expect{
      click_link "delete"
    }.to change{Rating.count}.from(1).to(0)
  end
end