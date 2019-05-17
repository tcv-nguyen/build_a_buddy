class AccessoryCompatibility < ApplicationRecord
  belongs_to :stuffed_animal
  belongs_to :accessory

  validates :stuffed_animal_id, uniqueness: { scope: [:accessory_id] }
end
