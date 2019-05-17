class CreateProductAccessories < ActiveRecord::Migration[5.2]
  def change
    create_table :product_accessories do |t|
      t.integer :custom_product_id
      t.integer :accessory_id
      t.decimal :accessory_price

      t.timestamps
    end

    add_index :product_accessories, :custom_product_id
    add_index :product_accessories, :accessory_id
  end
end
