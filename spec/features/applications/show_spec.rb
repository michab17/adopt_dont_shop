require 'rails_helper'

RSpec.describe 'Applications Show Page' do
  it 'displays all of the applications attributes' do
    app = Application.create!(name: 'Jen', street_address: '123 Street Dr', city: 'Pittsburgh', state: 'PA', zip_code: '15238', description: "", names_of_pets: "", status: 'In Progress')  
    visit "/applications/#{app.id}"

    expect(page).to have_content('Jen')
    expect(page).to have_content('123 Street Dr')
    expect(page).to have_content('Pittsburgh')
    expect(page).to have_content('PA')
    expect(page).to have_content('15238')
    expect(page).to have_content('In Progress')
  end

  describe 'searching for Pets for an Application' do
    it 'has a search field where the user can search for pets' do
      app = Application.create!(name: 'Jen', street_address: '123 Street Dr', city: 'Pittsburgh', state: 'PA', zip_code: '15238', description: "", names_of_pets: "", status: 'In Progress')
      visit "/applications/#{app.id}"

      expect(page).to have_content "Add a Pet to this Application"
      expect(page).to have_content "Search by name:"
    end

    it 'displays the pets under the search bar when searched' do
      app = Application.create!(name: 'Jen', street_address: '123 Street Dr', city: 'Pittsburgh', state: 'PA', zip_code: '15238', description: "", names_of_pets: "", status: 'In Progress')
      shelter = Shelter.create!(name: 'Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
      pet = Pet.create!(name: 'Charles', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter.id)
  
      visit "/applications/#{app.id}"

      fill_in "search", with: 'Charles'

      click_button 'Search'

      expect(page).to have_content('charles')
      expect(page).to have_content('2')
      expect(page).to have_content('Doberman')
      expect(page).to have_content('true')
    end

    it 'give the user an option to add a pet to an application' do
      app = Application.create!(name: 'Jen', street_address: '123 Street Dr', city: 'Pittsburgh', state: 'PA', zip_code: '15238', description: "", names_of_pets: "", status: 'In Progress')      
      shelter = Shelter.create!(name: 'Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
      pet = Pet.create!(name: 'Charles', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter.id)
  
      visit "/applications/#{app.id}"

      fill_in "search", with: 'Charles'

      click_button 'Search'

      expect(page).to have_button('Adopt this Pet')
    end

    it 'can complete the application submitting process' do
      app = Application.create!(name: 'Jen', street_address: '123 Street Dr', city: 'Pittsburgh', state: 'PA', zip_code: '15238', description: "", names_of_pets: "", status: 'In Progress')
      shelter = Shelter.create!(name: 'Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
      pet = Pet.create!(name: 'Charles', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter.id)
  
      visit "/applications/#{app.id}"

      fill_in "search", with: 'Charles'

      click_button 'Search'

      click_button 'Adopt this Pet'
      
      fill_in "description", with: "I like dogs"
      
      click_button 'Submit this Application'
      
      expect(page).to have_content('Charles')
      expect(page).to have_content('Pending')
      expect(page).to_not have_content('Search')
    end

    it 'returns pets that partially match the search' do
      app = Application.create!(name: 'Jen', street_address: '123 Street Dr', city: 'Pittsburgh', state: 'PA', zip_code: '15238', description: "", names_of_pets: "", status: 'In Progress')
      shelter = Shelter.create!(name: 'Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
      pet = Pet.create!(name: 'Charles', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter.id)
      pet = Pet.create!(name: 'Charley', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter.id)
  
      visit "/applications/#{app.id}"

      fill_in "search", with: 'Charle'

      click_button 'Search'

      expect(page).to have_content('charles')
      expect(page).to have_content('charley')
    end
  end
end