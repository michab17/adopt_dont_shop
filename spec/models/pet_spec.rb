require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it { should have_many :pet_applications }
    it { should have_many(:applications).through(:pet_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end

    describe '#pending_shelters' do
      it 'displays pending shelters' do
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

        expect(Pet.pending_shelters).to eq([pet1, pet2])
      end
    end

    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end
  end

  describe 'instance methods' do
    describe '.shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end
  end
end
