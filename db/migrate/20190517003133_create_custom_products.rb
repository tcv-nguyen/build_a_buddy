class CreateCustomProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :custom_products do |t|
      t.integer :order_id, null: false
      t.decimal :price, default: 0

      t.timestamps
    end

    add_index :custom_products, :order_id
  end
end
