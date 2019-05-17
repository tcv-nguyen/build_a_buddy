class CustomProduct < ApplicationRecord
  belongs_to :order
  belongs_to :stuffed_animal # This also help validate each CustomProduct must have StuffedAnimal
  has_many :product_accessories
  has_many :accessories, through: :product_accessories

  def add_accessory(accessory, possible_accessories, max_price)
    if sale_price + accessory.sale_price <= max_price
      unless product_accessories.map(&:accessory_id).include?(accessory.id)
        product_accessories.new(accessory: accessory)
      end
      if next_accessory = possible_accessories.shift
        add_accessory(next_accessory, possible_accessories, max_price)
      end
    end
    self
  end

  def sale_price
    stuffed_animal.sale_price + product_accessories.sum(&:sale_price)
  end

  def profit
    stuffed_animal.profit + product_accessories.sum(&:profit)
  end

  def same_as?(product)
    stuffed_animal == product.stuffed_animal && 
      product_accessories.map(&:accessory).sort == product.product_accessories.map(&:accessory).sort
  end
end
