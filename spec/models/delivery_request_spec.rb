require 'rails_helper'

RSpec.describe DeliveryRequest, type: :model do

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
