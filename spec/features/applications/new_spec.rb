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
end