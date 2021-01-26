class User < ApplicationRecord
    has_secure_password
    has_secure_token 
    
    has_many :bookings
    has_many :booked_taxis, through: :bookings, source: :taxi

    has_many :blogs

	  DRIVER = "Driver"

    has_one :driver
    
    # validates :email, presence: true, uniqueness: true
	  # validates :first_name, :last_name, :password, :password_confirmation, presence: true
	  # validates :password, :password_confirmation, :length => {:within => 6..40}

    
	  def driver
		  Driver.find_by(user_id: self.id)
    end
    
  end
