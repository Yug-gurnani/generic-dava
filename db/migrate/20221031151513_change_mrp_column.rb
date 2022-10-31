class ChangeMrpColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :products, :max_price, :float
    change_column :products, :selling_price, :float
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
