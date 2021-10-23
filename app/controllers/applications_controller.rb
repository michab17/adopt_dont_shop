class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if @application.names_of_pets == nil
      @application.names_of_pets = params[:adopt]
      @application.save
      @application = Application.find(params[:id])
    elsif @application.names_of_pets != nil
      @application.names_of_pets = @application.names_of_pets + " " + "#{params[:adopt]}"
      @application.save
      @application = Application.find(params[:id])
    end
    if params[:search]
      @pets = Pet.search(params[:search])
    else
      @pets = []
    end
    if @application.names_of_pets != nil
      @pet_added = true
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