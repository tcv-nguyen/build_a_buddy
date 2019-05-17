class AddColumnQuantityToAccessories < ActiveRecord::Migration[5.2]
  def change
    add_column :accessories, :quantity, :integer, default: 0
  end
end
