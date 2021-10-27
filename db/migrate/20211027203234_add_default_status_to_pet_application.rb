class AddDefaultStatusToPetApplication < ActiveRecord::Migration[5.2]
  def change
    change_column :pet_applications, :status, :string, default: "Pending"
  end
end
