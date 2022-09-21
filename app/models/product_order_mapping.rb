# == Schema Information
#
# Table name: product_order_mappings
#
#  id         :bigint           not null, primary key
#  quantity   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer
#  product_id :integer
#
# Indexes
#
#  index_product_order_mappings_on_order_id_and_product_id  (order_id,product_id) UNIQUE
#
class ProductOrderMapping < ApplicationRecord
  belongs_to :order
  belongs_to :product
end
