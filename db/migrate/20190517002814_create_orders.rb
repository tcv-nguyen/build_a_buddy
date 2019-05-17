class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.datetime :completed_at
      t.decimal :total, default: 0

      t.timestamps
    end
  end
end
