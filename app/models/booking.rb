class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :taxi

  AVAILABLE = "Available"
  CLOSED = "Closed"

  validates :taxi_id, presence: true
  validates :user_id, presence: true
  validates :status, presence: true, inclusion: [AVAILABLE, CLOSED]
end
