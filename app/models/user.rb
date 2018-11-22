class User < ApplicationRecord
    has_many :rentals, dependent: :destroy
end
