# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LocationsController, type: :request do
  let(:uuid) { '8bc097e0-1923-41b3-a9c3-4c7dc590b2f7' }
  let(:lat) { 52.53 }
  let(:lng) { 13.403 }
  let!(:vehicle) { Vehicle.create(uuid: uuid, active: true) }

  describe 'POST /vehicles/:vehicle_id/locations' do
    subject do
      post vehicle_locations_path(vehicle_id: uuid), params: {
        location: { lat: lat, lng: lng, at: Time.now }
      }
    end

    context 'when vehicle is within radius' do
      it 'checks that the vehicle is within radius' do
        subject
        expect(response.status).to eq 204
      end

      it 'creates a vehicle location' do
        subject
        expect(vehicle.locations.count).to eq 1
      end
    end

    context 'when vehicle is outside of radius' do
      let(:lat) { 49.13 }

      it 'checks that the vehicle is within radius' do
        subject
        expect(response.status).to eq 204
      end

      it 'does not create a vehicle location' do
        subject
        expect(vehicle.locations.count).to eq 0
      end
    end
  end
end
