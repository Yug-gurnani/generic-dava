class AddProductStoreMappingTable < ActiveRecord::Migration[6.0]
  def change
    create_table :product_cart_mappings do |t|
      t.integer :cart_id
      t.integer :product_id
      t.integer :quantity, default: 0

      t.timestamps
    end

    create_table :product_order_mappings do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :quantity, default: 0

      t.timestamps
    end
    add_index :product_cart_mappings, %i[cart_id product_id], unique: true
    add_index :product_order_mappings, %i[order_id product_id], unique: true
  end
end
