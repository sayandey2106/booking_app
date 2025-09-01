class Movie < ApplicationRecord
  has_many :bookings, dependent: :destroy

  validates :title, presence: true
  validates :language, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
end