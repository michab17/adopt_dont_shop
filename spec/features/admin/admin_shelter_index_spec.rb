require 'rails_helper'

RSpec.describe 'Admin Shelter Index page' do
  it 'displays all of the shelters in reverse alphabetical order' do
    shelter1 = Shelter.create!(name: 'Awesome Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
    shelter2 = Shelter.create!(name: 'Best Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
    shelter3 = Shelter.create!(name: 'Cool Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
    shelter4 = Shelter.create!(name: 'Dang Great Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)

    visit '/admin/shelters'
    save_and_open_page
    
    expect(shelter4.name).to appear_before(shelter3.name)
    expect(shelter3.name).to appear_before(shelter2.name)
    expect(shelter2.name).to appear_before(shelter1.name)
  end
end