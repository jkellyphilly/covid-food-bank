require 'rails_helper'

RSpec.describe DeliveryRequest, type: :model do
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

  it 'is valid with a valid date & items' do
    delivery_request_2 = DeliveryRequest.new(items: "testing", requested_date: "09/01/2200")

    expect(delivery_request_2.valid?).to eq(true)
  end

  it 'is not valid with no items' do
    delivery_request_2 = DeliveryRequest.new(requested_date: "09/01/2200")

    expect(delivery_request_2.valid?).to eq(false)
  end

  it 'is not valid with a past date' do
    delivery_request_2 = DeliveryRequest.new(items: "testing", requested_date: "09/01/2000")

    expect(delivery_request_2.valid?).to eq(false)
  end

  
end
