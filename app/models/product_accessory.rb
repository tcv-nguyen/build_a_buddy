class ProductAccessory < ApplicationRecord
  belongs_to :custom_product
  belongs_to :accessory

  delegate :profit, :sale_price, to: :accessory
end
