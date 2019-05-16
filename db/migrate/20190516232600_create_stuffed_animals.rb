class CreateStuffedAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :stuffed_animals do |t|
      t.string :name, null: false
      t.decimal :cost, default: 0
      t.decimal :sale_price, default: 0

      t.timestamps
    end
  end
end
