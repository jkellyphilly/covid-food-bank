class LoadDeliveryRequestsJob < ApplicationJob
  queue_as :default

  def perform
    puts "HELLOOOOO"
  end

end
