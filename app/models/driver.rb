class Driver < ApplicationRecord
    ACTIVE = 'Active'
	BUSY = 'Busy'
    TRANSIT = 'Transit'
	INACTIVE = 'Inactive'
	INVISIBLE = 'Invisible'

    belongs_to :user
    validates :status, presence: true, inclusion: [ACTIVE, BUSY, TRANSIT,INACTIVE,INVISIBLE]
end
