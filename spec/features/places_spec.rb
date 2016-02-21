require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "if many returned by the API, all are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("helsinki").and_return(
        [ Place.new( name:"korsi", id: 2 ) ],
        [ Place.new( name:"mesta", id: 3 ) ],
        [ Place.new( name:"paikka", id: 4 ) ]
    )

    visit places_path
    fill_in('city', with: 'helsinki')
    click_button "Search"

    expect {
      (page).have_content "korsi"
      (page).have_content "mesta"
      (page).have_content "paikka"
    }
  end
  it "if none returned by API, notification is shown" do
    allow(BeermappingApi).to receive(:places_in).with("menomesta").and_return(
        []
    )
    visit places_path
    fill_in('city', with: 'menomesta')
    click_button "Search"

    expect(page).to have_content "Beer places search"
  end
end