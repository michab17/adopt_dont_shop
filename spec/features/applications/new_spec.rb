require 'rails_helper'

RSpec.describe 'Applications new page' do
  it 'allows the user to create a new application' do
    visit '/applications/new'

    fill_in 'name', with: 'Jen'
    fill_in 'street_address', with: '123 Street'
    fill_in 'city', with: 'Pittsburgh'
    fill_in 'state', with: 'PA'
    fill_in 'zip_code', with: '15238'

    click_button "submit"

    expect(page).to have_content('Jen')
    expect(page).to have_content('123 Street')
    expect(page).to have_content('Pittsburgh')
    expect(page).to have_content('PA')
    expect(page).to have_content('15238')
  end

  describe 'when the form is not fully completed' do
    it 'displays a message that says all fields must be filled' do
      visit '/applications/new'

      click_button "submit"

      expect(current_path).to eq('/applications/new')
      expect(page).to have_content('Error: Please fill in all fields before submitting')
    end
  end
end