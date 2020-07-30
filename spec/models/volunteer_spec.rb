require 'pry'
require 'rails_helper'

RSpec.describe Volunteer, type: :model do
  before do
    @member = CommunityMember.create(name: "Testy McTestFace", username: "test 123", email: "test123@mailinator.com", address: "Testing Address", phone_number: "1234567890", allergies: "sesame", password: "test")
    @volunteer = Volunteer.create(name: "Testy Volunteer", username: "vol_test", email: "iluv2volunteer@gmail.com", phone_number: "1112223345", password: "test")
    @delivery_request = DeliveryRequest.new(items: "milk and cookies", requested_date: "09/19/2200")
    @delivery_route = DeliveryRoute.new(estimated_delivery_date: "09/19/2200")
    @volunteer.delivery_routes << @delivery_route
    @member.delivery_requests << @delivery_request
    @member.save
    @delivery_request.save
  end

  it 'has a secure password' do

    expect(@volunteer.authenticate("dog")).to eq(false)

    expect(@volunteer.authenticate("test")).to eq(@volunteer)
  end

  it 'can keep track of all its confirmed delivery routes' do
    @delivery_route.delivery_requests << @delivery_request
    @delivery_route.status = "confirmed"
    @volunteer.save
    @delivery_route.save

    expect(@volunteer.upcoming_delivery_routes.size).to eq(1)
    expect(@volunteer.upcoming_delivery_routes.first.estimated_delivery_date).to eq("09/19/2200")
  end

  it 'can keep track of all its completed delivery routes' do
    @delivery_route.delivery_requests << @delivery_request
    @delivery_route.status = "completed"
    @volunteer.save
    @delivery_route.save

    expect(@volunteer.completed_delivery_routes.size).to eq(1)
    expect(@volunteer.completed_delivery_routes.first.estimated_delivery_date).to eq("09/19/2200")
  end

  # TODO: add a test for find_or_create_new_route

  it 'creates a new route for a delivery request with a new date' do
    @delivery_request_2 = DeliveryRequest.new(items: "spaghetti", requested_date: "09/20/2200")
    @member.delivery_requests << @delivery_request_2
    @member.save

    @new_route = @volunteer.find_or_create_new_route(@delivery_request_2)
    expect(@new_route.estimated_delivery_date).to eq("09/20/2200")
  end

  it 'finds an existing route for a delivery request with an existing date' do

    @route = @volunteer.find_or_create_new_route(@delivery_request)
    expect(@route.id).to eq(@delivery_route.id)
  end
end
