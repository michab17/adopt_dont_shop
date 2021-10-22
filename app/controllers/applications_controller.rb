class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    app = Application.new(application_params)

    app.save

    redirect_to "/applications/#{app.id}"
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :names_of_pets, :status)
  end
end