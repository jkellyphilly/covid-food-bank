require 'rails_helper'

RSpec.describe DeliveryRoute, type: :model do
  before do
    @member = CommunityMember.create(name: "Testy McTestFace", username: "test 123", email: "test123@mailinator.com", address: "Testing Address", phone_number: "1234567890", allergies: "sesame", password: "test")
    @volunteer = Volunteer.create(name: "Testy Volunteer", username: "vol_test", email: "iluv2volunteer@gmail.com", phone_number: "1112223345", password: "test")
    @delivery_request = DeliveryRequest.new(items: "milk and cookies", requested_date: "09/19/2200")
    @delivery_route = DeliveryRoute.new(estimated_delivery_date: "09/20/2200")
    @volunteer.delivery_routes << @delivery_route
    @delivery_route.delivery_requests << @delivery_request
    @member.delivery_requests << @delivery_request
    @member.save
    @volunteer.save
    @delivery_route.save
    @delivery_request.save
  end

  it 'correctly updates all statuses to confirmed' do
    @delivery_route.update_all_statuses("confirmed")

    expect(@delivery_request.status).to eq("confirmed")
  end

  it 'correctly updates all statuses to new and removes delivery route ID' do
    @delivery_route.update_all_statuses("new")

    expect(@delivery_request.status).to eq("new")
    expect(@delivery_request.delivery_route_id).to eq(nil)
  end

end
