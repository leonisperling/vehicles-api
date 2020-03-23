RSpec.describe VehiclesController, type: :controller do
  let(:uuid) { "8bc097e0-1923-41b3-a9c3-4c7dc590b2f7" }

  describe "POST /vehicles" do
    subject { post vehicles_path, params: { id: uuid } }

    context "when vehicle does not exist" do

      it "creates a vehicle" do
        subject
        expect(Vehicle.last.uuid).to eq uuid
      end

    end

    context "when vehicle exists" do
      vehicle = Vehicle.create!(uuid: uuid, active: false)

      it "makes the vehicle 'active'" do
        subject
        expect(vehicle.active).to eq true
      end
    end
  end

  describe "DELETE /vehicles/:id" do
    subject { delete vehicles_path, params: { id: uuid } }

    it "makes the vehicle inactive" do
      subject
      expect(Vehicle.last.active).to eq false
    end
    
    it "responds with 204" do
      subject
      expect(response.status).to eq 204
    end
  end 
end