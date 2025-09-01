class Booking < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :show_time, :seat_number, presence: true
end