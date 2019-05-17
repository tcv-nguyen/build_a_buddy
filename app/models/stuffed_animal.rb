class StuffedAnimal < ApplicationRecord
  include ModelHelper
  
  has_many :accessory_compatibilities
  has_many :accessories, through: :accessory_compatibilities
  has_many :custom_products # This help calculate how many StuffedAnimal has been added to cart
  
  validates :name, presence: true
end
