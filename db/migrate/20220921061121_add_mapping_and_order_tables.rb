class AddMappingAndOrderTables < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.boolean :delivered, default: false

      t.timestamps
    end
    add_index :orders, :user_id, unique: true
  end
end
