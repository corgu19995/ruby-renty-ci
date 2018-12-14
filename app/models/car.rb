class Car < ApplicationRecord    
    has_many :pictures, dependent: :destroy
    has_many :bookings, dependent: :destroy    
    belongs_to :rental
    belongs_to :type_vehicle    
end
