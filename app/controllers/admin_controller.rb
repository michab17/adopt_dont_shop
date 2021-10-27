class AdminController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY shelters.name DESC")
    @pending_pets = Pet.pending_shelters
  end

  def show
    @application = Application.find(params[:id])
    if params[:status] == "approved"
      @pa = PetApplication.find_by(pet_id: params[:pet_id], application_id: @application.id)
      @pa.status = "Approved"
      @pa.save
    elsif params[:status] == "denied"
      @pa = PetApplication.find_by(pet_id: params[:pet_id], application_id: @application.id)
      @pa.status = "Denied"
      @pa.save
    end
  end
end 