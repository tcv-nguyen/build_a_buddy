class ProductAccessory < ApplicationRecord
  belongs_to :custom_product
  belongs_to :accessory
end
