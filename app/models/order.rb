# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  delivered  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
class Order < ApplicationRecord
  belongs_to :user
  has_many :product_order_mappings, dependent: :destroy
  has_many :products, through: :product_order_mappings
end
