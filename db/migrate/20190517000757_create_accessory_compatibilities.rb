class CreateAccessoryCompatibilities < ActiveRecord::Migration[5.2]
  def change
    create_table :accessory_compatibilities do |t|
      t.integer :stuffed_animal_id, :accessory_id

      t.timestamps
    end

    add_index :accessory_compatibilities, :stuffed_animal_id
    add_index :accessory_compatibilities, :accessory_id
    add_index :accessory_compatibilities, [:stuffed_animal_id, :accessory_id], unique: true, 
      name: :stuffed_animal_accessory_index
  end
end
