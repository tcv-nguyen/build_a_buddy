class CreateAccessories < ActiveRecord::Migration[5.2]
  def change
    create_table :accessories do |t|
      t.string :name, null: false
      t.string :size, null: false
      t.decimal :cost, default: 0
      t.decimal :sale_price, default: 0

      t.timestamps
    end

    add_index :accessories, [:name, :size], unique: true
  end
end
