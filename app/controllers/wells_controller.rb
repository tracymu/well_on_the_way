class WellsController < ApplicationController

  before_filter :check_api_key, only: :create

  def index
    @wells = Well.all
    render json: @wells, each_serializer: WellSerializer
  end

  def show
    @well = Well.find(params[:id])
    render json: @well, serializer: WellSerializer
  end

  def create
    @well = Well.new(well_params)
    @well.save
    render json: @well, serializer: WellSerializer
  end

  private

  def well_params
    params.require(:well).permit(:latitude, :longitude, :postcode, :suburb, :country, :description, :image)
  end
end
