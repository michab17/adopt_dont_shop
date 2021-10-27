require 'rails_helper'

RSpec.describe 'Admin Shelter Index page' do
  it 'displays all of the shelters in reverse alphabetical order' do
    shelter1 = Shelter.create!(name: 'Awesome Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
    shelter2 = Shelter.create!(name: 'Best Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
    shelter3 = Shelter.create!(name: 'Cool Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
    shelter4 = Shelter.create!(name: 'Dang Great Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)

    visit '/admin/shelters'

    expect(shelter4.name).to appear_before(shelter3.name)
    expect(shelter3.name).to appear_before(shelter2.name)
    expect(shelter2.name).to appear_before(shelter1.name)
  end

  it 'has a section for shelters with pending applications' do
    shelter1 = Shelter.create!(name: 'Awesome Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
    shelter2 = Shelter.create!(name: 'Best Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
    shelter3 = Shelter.create!(name: 'Cool Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)

    pet1 = Pet.create!(name: 'Charles', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter1.id)
    pet2 = Pet.create!(name: 'Charley', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter2.id)
    pet3 = Pet.create!(name: 'Char', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter3.id)

    app1 = Application.create!(name: 'Jen', street_address: '123 Street Dr', city: 'Pittsburgh', state: 'PA', zip_code: '15238', description: "I really like dogs", status: 'Pending')
    app2 = Application.create!(name: 'Micha', street_address: '123 Street Dr', city: 'Pittsburgh', state: 'PA', zip_code: '15238', description: "I really like dogs", status: 'Pending')
    app3 = Application.create!(name: 'Kevin', street_address: '123 Street Dr', city: 'Pittsburgh', state: 'PA', zip_code: '15238', description: "I really like dogs", status: 'In Progress')

    PetApplication.create!(pet: pet1, application: app1)
    PetApplication.create!(pet: pet2, application: app2)
    PetApplication.create!(pet: pet3, application: app3)

    visit '/admin/shelters'

    within("#pending-shelters") do
      expect(page).to have_content("Shelter's with Pending Applications")
      expect(page).to have_content(shelter1.name)
      expect(page).to have_content(shelter2.name)
    end
  end
end