class Car < ApplicationRecord
    has_many :rentals, dependent: :destroy
    has_many :pictures, dependent: :destroy    
end
