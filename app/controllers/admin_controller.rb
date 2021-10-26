class AdminController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY shelters.name DESC")
    @pending_pets = Pet.pending_shelters
  end

  def show
    @application = Application.find(params[:id])
  end
end 