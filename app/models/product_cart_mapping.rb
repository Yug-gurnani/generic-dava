# == Schema Information
#
# Table name: product_cart_mappings
#
#  id         :bigint           not null, primary key
#  quantity   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cart_id    :integer
#  product_id :integer
#
# Indexes
#
#  index_product_cart_mappings_on_cart_id_and_product_id  (cart_id,product_id) UNIQUE
#
class ProductCartMapping < ApplicationRecord
  belongs_to :cart
  belongs_to :product
end
