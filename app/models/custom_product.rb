class CustomProduct < ApplicationRecord
  belongs_to :order
  belongs_to :stuffed_animal # This also help validate each CustomProduct must have StuffedAnimal
end
