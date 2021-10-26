class RemoveNamesOfPetsFromApplications < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications, :names_of_pets, :string
  end
end
