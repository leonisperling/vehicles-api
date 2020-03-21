# frozen_string_literal: true

# Locations Controller
class LocationsController < ApplicationController
  # setting office coordinates and radius as constants because they
  # are not supposed to change
  OFFICE_COORDINATES = [52.53, 13.403]
  RADIUS = 3.5

  # finding the vehicle before anything else happens
  before_action :set_vehicle

  def create
    # created two early returns that check if the vehicle is within radius and
    # checks that it is active
    return unless within_radius?
    return unless @vehicle.active

    # creating new location
    @location = Location.new(location_params)

    # assigning a location to a vehicle
    @location.vehicle = @vehicle
    # rendering the JSON
    if @location.save
      broadcast_location
      render json: nil, status: 204
    else
      render json: @location.errors, status: 403
    end
  end

  private

  def location_params
    params.require(:location).permit(:lat, :lng, :at)
  end

  # calculating the distance between the office and the location of the vehicle
  def within_radius?
    distance = Geocoder::Calculations.distance_between(
      OFFICE_COORDINATES, coordinates
    )

    # returns true when the distance is less than the radius
    distance <= RADIUS
  end

  # this method receives lat and lng
  def coordinates
    [params[:lat], params[:lng]]
  end

  # finding the vehicle and using this method as before_action
  def set_vehicle
    @vehicle = Vehicle.find_by(uuid: params[:vehicle_id])
  end

  # You can simulate a connection to listen for changes using the following body:
  # {"command":"subscribe","identifier":"{\"channel\":\"LocationsChannel\"}"}
  def broadcast_location
    ActionCable.server.broadcast(
      'locations',
      latitude: @location.lat,
      longitude: @location.lng,
      at: @location.at
    )
  end
end
