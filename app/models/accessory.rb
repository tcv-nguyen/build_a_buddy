class Accessory < ApplicationRecord
  validates :name, presence: true
  validates :size, presence: true, uniqueness: { scope: [:name] }
end
