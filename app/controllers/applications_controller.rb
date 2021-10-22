class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search]
      @pets = Pet.search(params[:search])
    else
      @pets = []
    end
    if params[:adopt]
      @application.names_of_pets = params[:adopt]
    end
  end

  def new
  end

  def create
    app = Application.new(application_params)

    if application_params.values.include?("")
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