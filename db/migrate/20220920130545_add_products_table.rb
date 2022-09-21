# frozen_string_literal: true

class AddProductsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, default: ''
      t.text :description
      t.integer :total_stock, default: 0
      t.integer :max_price
      t.integer :selling_price
      t.string :image_url, default: ''

      t.timestamps
    end
    add_index :products, :name, unique: true
  end
end
