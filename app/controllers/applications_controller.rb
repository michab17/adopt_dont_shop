class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:adopt]
      PetApplication.create!(pet: Pet.find(params[:adopt]), application: Application.find(@application.id))
      @pet_added = true
    end
    if params[:search]
      @searched_pets = Pet.where("lower(name) LIKE ?", "%#{params[:search].downcase}%")
    else
      @searched_pets = []
    end
    if params[:description]
      @application.description = params[:description]
      @application.status = "Pending"
      @application.save
    end
  end

  def new
  end

  def create
    app = Application.new(application_params)
    
    if application_params.values[0..4].include?("")
      redirect_to '/applications/new'
      flash[:alert] = "Error: Please fill in all fields before submitting"
    else
      app.save
      redirect_to "/applications/#{app.id}"
    end
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :names_of_pets, :status)
  end
end