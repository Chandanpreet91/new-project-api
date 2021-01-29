class Blog < ApplicationRecord
  
    has_many :comments, dependent: :destroy
    belongs_to :user 

      
    validates :title, presence: true, uniqueness: true 
    validates :description, presence:true, length: {minimum:50}
end
