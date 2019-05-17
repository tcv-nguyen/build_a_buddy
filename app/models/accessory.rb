class Accessory < ApplicationRecord
  include ModelHelper
  
  has_many :product_accessories # This help calculate which accessories were added to cart the most.
  
  validates :name, presence: true
  validates :size, presence: true, uniqueness: { scope: [:name] }
end
