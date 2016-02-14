require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "has valid name and style" do
    beer = Beer.create name:"Koff", style:"Lager"
    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end
  it "can't validate without name" do
    beer = Beer.create name:"", style:"Lager"
    expect(beer).not_to be_valid
  end
  it "can't validate without style" do
    beer = Beer.create name:"", style:"Lager"
    expect(beer).not_to be_valid
  end
  it "is the one with highest rating if several rated" do
    user = FactoryGirl.create(:user)
    create_beer_with_rating(user, 10)
    best = create_beer_with_rating(user, 25)
    create_beer_with_rating(user, 7)

    expect(user.favorite_beer).to eq(best)
  end

  def create_beer_with_rating(user, score)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end
end
