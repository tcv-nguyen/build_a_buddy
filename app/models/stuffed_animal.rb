class StuffedAnimal < ApplicationRecord
  has_many :accessory_compatibilities
  has_many :accessories, through: :accessory_compatibilities
  
  validates :name, presence: true
end
