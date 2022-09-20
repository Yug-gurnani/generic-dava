class AddFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :verified, :boolean, default: false
    add_column :users, :address, :text
    add_column :users, :phone_number, :string
    add_column :users, :first_name, :string, default: ''
    add_column :users, :last_name, :string, default: ''
    add_column :users, :image_url, :string, default: ''
    add_column :users, :user_type, :integer, default: 0
  end
end
