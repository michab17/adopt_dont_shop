# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter1 = Shelter.create!(name: 'Awesome Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
shelter2 = Shelter.create!(name: 'Best Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)
shelter3 = Shelter.create!(name: 'Cool Shelter', city: 'Pittsburgh PA', foster_program: false, rank: 9)

pet1 = Pet.create!(name: 'Charles', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter1.id)
pet2 = Pet.create!(name: 'Charley', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter2.id)
pet3 = Pet.create!(name: 'Char', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter3.id)

app1 = Application.create!(name: 'Jen', street_address: '123 Street Dr', city: 'Pittsburgh', state: 'PA', zip_code: '15238', description: "I really like dogs", status: 'Pending')

PetApplication.create!(pet: pet1, application: app1)
PetApplication.create!(pet: pet2, application: app1)
PetApplication.create!(pet: pet3, application: app1)
