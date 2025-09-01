class BookingMailer < ApplicationMailer
  def booking_confirmation(booking)
    @booking = booking
    Rails.logger.info "Booking confirmation email sent to #{@booking.user.email} for booking ID #{@booking.id}"
  end
end