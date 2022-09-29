class AddCategoryToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :category, :integer, default: 0
    rename_column :users, :last_name, :google_id
    rename_column :users, :first_name, :name
  end
end
