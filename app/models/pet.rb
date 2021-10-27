class Pet < ApplicationRecord
  validates :name, presence: true # , uniqueness: {case_sensitive: false}
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.pending_shelters
    joins(applications: :pet_applications).where(applications: {status: 'Pending'})
  end

  # def self.status
  #   find_by_sql("SELECT pa.status FROM pets p INNER JOIN pet_applications pa ON pa.pet_id = p.id")
  # end
end
