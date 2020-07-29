require 'pry'
require 'rails_helper'

RSpec.describe CommunityMember, type: :model do
  before do
    @member = CommunityMember.create(name: "Testy McTestFace", username: "test 123", email: "test123@mailinator.com", address: "Testing Address", phone_number: "1234567890", allergies: "sesame", password: "test")
    @volunteer = Volunteer.create(name: "Testy Volunteer", username: "vol_test", email: "iluv2volunteer@gmail.com", phone_number: "1112223345", password: "test")
    @delivery_request = DeliveryRequest.new(items: "milk and cookies", requested_date: "09/19/2200")
    @delivery_route = DeliveryRoute.new(estimated_delivery_date: "09/20/2200")
    @volunteer.delivery_routes << @delivery_route
    @member.delivery_requests << @delivery_request
    @member.save
    @delivery_request.save
  end

  it 'has a secure password' do

    expect(@member.authenticate("dog")).to eq(false)

    expect(@member.authenticate("test")).to eq(@member)
  end

  it 'can keep track of all its new delivery requests' do

    expect(@member.pending_delivery_requests.size).to eq(1)
    expect(@member.pending_delivery_requests.first.items).to eq("milk and cookies")
  end

  it 'can keep track of all its confirmed delivery requests' do
    @delivery_route.delivery_requests << @delivery_request
    @volunteer.delivery_routes << @delivery_route
    @volunteer.save
    @delivery_route.save
    @delivery_request.status = "confirmed"
    @delivery_request.save

    expect(@member.confirmed_delivery_requests.size).to eq(1)
    expect(@member.confirmed_delivery_requests.first.items).to eq("milk and cookies")
    expect(@member.pending_delivery_requests.size).to eq(0)
  end

  it 'can keep track of all its completed delivery requests' do
    @delivery_route.delivery_requests << @delivery_request
    @volunteer.delivery_routes << @delivery_route
    @volunteer.save
    @delivery_route.save
    @delivery_request.status = "completed"
    @delivery_request.save

    expect(@member.completed_delivery_requests.size).to eq(1)
    expect(@member.completed_delivery_requests.first.items).to eq("milk and cookies")
    expect(@member.confirmed_delivery_requests.size).to eq(0)
    expect(@member.pending_delivery_requests.size).to eq(0)
  end
end
