class BookingConfirmationJob < ApplicationJob
  queue_as :default

  def perform(booking_id)
    booking = Booking.find(booking_id)
    BookingMailer.booking_confirmation(booking).deliver_now
  end
end
