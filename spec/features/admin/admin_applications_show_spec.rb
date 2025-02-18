require 'rails_helper'

RSpec.describe 'Admin Applications Show page' do
  it 'has buttons to approve pets in an application' do
    shelter1 = Shelter.create!(name: 'Awesome Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
    pet1 = Pet.create!(name: 'Charles', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter1.id)
    pet2 = Pet.create!(name: 'Kevin', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter1.id)
    app1 = Application.create!(name: 'Jen', street_address: '123 Street Dr', city: 'Pittsburgh', state: 'PA', zip_code: '15238', description: "I really like dogs", status: 'Pending')

    PetApplication.create!(pet: pet1, application: app1)

    visit "admin/applications/#{app1.id}"

    expect(page).to have_content("#{pet1.name}")
    expect(page).to have_button("Approve")
  end

  it 'gets rid of the button and labels the pet name as approved if clicked' do
    shelter1 = Shelter.create!(name: 'Awesome Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
    pet1 = Pet.create!(name: 'Charles', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter1.id)
    pet2 = Pet.create!(name: 'Kevin', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter1.id)
    app1 = Application.create!(name: 'Jen', street_address: '123 Street Dr', city: 'Pittsburgh', state: 'PA', zip_code: '15238', description: "I really like dogs", status: 'Pending')

    PetApplication.create!(pet: pet1, application: app1)
    PetApplication.create!(pet: pet2, application: app1)

    visit "admin/applications/#{app1.id}"

    within("#id-#{pet1.id}") do
      click_button 'Approve'
      expect(page).to have_content('Charles: Approved')
    end
  end

  it 'has buttons to approve pets in an application' do
    shelter1 = Shelter.create!(name: 'Awesome Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
    pet1 = Pet.create!(name: 'Charles', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter1.id)
    pet2 = Pet.create!(name: 'Kevin', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter1.id)
    app1 = Application.create!(name: 'Jen', street_address: '123 Street Dr', city: 'Pittsburgh', state: 'PA', zip_code: '15238', description: "I really like dogs", status: 'Pending')

    PetApplication.create!(pet: pet1, application: app1)

    visit "admin/applications/#{app1.id}"

    expect(page).to have_content("#{pet1.name}")
    expect(page).to have_button("Deny")
  end
end