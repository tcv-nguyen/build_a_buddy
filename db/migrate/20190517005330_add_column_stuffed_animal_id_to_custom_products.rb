class AddColumnStuffedAnimalIdToCustomProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :custom_products, :stuffed_animal_id, :integer
    add_column :custom_products, :stuffed_animal_price, :decimal, default: 0
    add_index :custom_products, :stuffed_animal_id
  end
end
