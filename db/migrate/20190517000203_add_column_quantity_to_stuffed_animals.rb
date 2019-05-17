class AddColumnQuantityToStuffedAnimals < ActiveRecord::Migration[5.2]
  def change
    add_column :stuffed_animals, :quantity, :integer, default: 0
  end
end
