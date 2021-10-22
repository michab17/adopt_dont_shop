require 'rails_helper'

RSpec.describe 'Applications Show Page' do
  it 'displays all of the applications attributes' do
    app = Application.create!(name: 'Jen', street_address: '123 Street Dr', city: 'Pittsburgh', state: 'PA', zip_code: '15238', description: 'I love dogs', names_of_pets: 'Jason, Michael', status: 'Pending')
  
    visit "/applications/#{app.id}"

    expect(page).to have_content('Jen')
    expect(page).to have_content('123 Street Dr')
    expect(page).to have_content('Pittsburgh')
    expect(page).to have_content('PA')
    expect(page).to have_content('15238')
    expect(page).to have_content('I love dogs')
    expect(page).to have_content('Jason, Michael')
    expect(page).to have_content('Pending')
  end

  describe 'searching for Pets for an Application' do
    it 'has a search field where the user can search for pets' do
      app = Application.create!(name: 'Jen', street_address: '123 Street Dr', city: 'Pittsburgh', state: 'PA', zip_code: '15238', description: 'I love dogs', names_of_pets: 'Jason, Michael', status: 'Pending')

      visit "/applications/#{app.id}"

      expect(page).to have_content "Add a Pet to this Application"
      expect(page).to have_content "Search by name:"
    end

    it 'displays the pets under the search bar when searched' do
      app = Application.create!(name: 'Jen', street_address: '123 Street Dr', city: 'Pittsburgh', state: 'PA', zip_code: '15238', description: 'I love dogs', names_of_pets: 'Jason, Michael', status: 'Pending')
      shelter = Shelter.create!(name: 'Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
      pet = Pet.create!(name: 'Charles', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter.id)
  
      visit "/applications/#{app.id}"

      fill_in "search", with: 'Charles'

      click_button 'Search'
      save_and_open_page
      expect(page).to have_content('Charles')
      expect(page).to have_content('2')
      expect(page).to have_content('Doberman')
      expect(page).to have_content('true')
    end
  end
end