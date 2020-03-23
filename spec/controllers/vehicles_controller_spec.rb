# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VehiclesController, type: :request do
  let(:uuid) { '8bc097e0-1923-41b3-a9c3-4c7dc590b2f7' }

  describe 'POST /vehicles' do
    subject { post vehicles_path, params: { id: uuid } }

    context 'when vehicle does not exist' do
      before do
        subject
      end

      it 'creates a vehicle' do
        expect(Vehicle.last.uuid).to eq uuid
      end

      it 'responds with success' do
        expect(response.status).to eq 204
      end
    end

    context 'when vehicle exists' do
      it "makes the vehicle 'active'" do
        vehicle = Vehicle.create!(uuid: uuid, active: false)
        subject
        expect(vehicle.reload.active).to eq true
      end

      it 'responds with success' do
        subject
        expect(response.status).to eq 204
      end
    end
  end

  describe 'DELETE /vehicles/:id' do
    subject { delete vehicle_path(id: uuid) }

    it 'makes the vehicle inactive' do
      Vehicle.create!(uuid: uuid, active: true)
      subject
      expect(Vehicle.last.active).to eq false
    end

    it 'responds with 204' do
      subject
      expect(response.status).to eq 204
    end
  end
end
