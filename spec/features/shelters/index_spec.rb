require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  
  before(:each) do
    @shelter_1 = Shelter.create({
            name: "Primary Shelter",
            address: "123 Maple Ave.",
            city: "Denver",
            state: "CO",
            zip: "80438"
            })
    @shelter_2 = Shelter.create({
              name: "Secondary Shelter",
              address: "321 Oak Ave.",
              city: "Denver",
              state: "CO",
              zip: "80438"
              })
  end
  
  it "When I visit /shelters I see the name of each shelter in the system" do

    visit '/shelters'
    
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
  end
  
  it "When I visit /shelters/:id I see all information pertaining to this shelter" do

    visit "/shelters/#{@shelter_1.id}"
    
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
    expect(page).to have_content(@shelter_1.city)
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip)
    
    visit "/shelters/#{@shelter_2.id}"
    
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_2.address)
    expect(page).to have_content(@shelter_2.city)
    expect(page).to have_content(@shelter_2.state)
    expect(page).to have_content(@shelter_2.zip)
  end
  
  it "When I visit /shelters, there is a link that takes me to a form to create a new shelter" do

    visit "/shelters"
    
    expect(page).to have_content("New Shelter")

    click_link 'New Shelter'

    expect(current_path).to eq('/shelters/new')

    fill_in 'Name', with: 'The New Shelter'
    fill_in 'Address', with: '12 Main St.'
    fill_in 'City', with: 'Conifer'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: '80423'
    
    click_on 'Create Shelter'

    expect(current_path).to eq("/shelters")
    expect(page).to have_content('The New Shelter')
  end
  
end