class VehiclesController < ApplicationController
  def create
    # if the vehicle doesn't exist it initializes it
    @vehicle = Vehicle.find_or_initialize_by(uuid: params[:id])
    # sets the vehicle as active
    @vehicle.active = true
    if @vehicle.save
      render json: nil, status: 204
    else
      render json: @vehicle.errors, status: 403
    end
  end

  def destroy
    # finds the vehicle
    @vehicle = Vehicle.find_by(uuid: params[:id])
    # sets it as inactive
    @vehicle.update(active: false)
    render nil, status: 204
  end
end
