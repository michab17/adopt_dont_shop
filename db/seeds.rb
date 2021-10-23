# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter1 = Shelter.create(name: 'Shelter1', city: 'Pittsburgh PA', foster_program: false, rank: 9)
charles = Pet.create(name: 'Charles', age: 2, breed: 'Doberman', adoptable: true, shelter_id: shelter1.id)

shelter2 = Shelter.create(name: 'Shelter2', city: 'Madison WI', foster_program: false, rank: 1)
johnny = Pet.create(name: 'Johnny', age: 10, breed: 'Chihuahua', adoptable: true, shelter_id: shelter2.id)

shelter2 = Shelter.create(name: 'Shelter2', city: 'Madison WI', foster_program: false, rank: 1)
john = Pet.create(name: 'John', age: 5, breed: 'Chihuahua', adoptable: true, shelter_id: shelter2.id)
