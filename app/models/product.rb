# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id            :bigint           not null, primary key
#  description   :text(65535)
#  image_url     :string(255)      default("")
#  max_price     :integer
#  name          :string(255)      default("")
#  selling_price :integer
#  total_stock   :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_products_on_name  (name) UNIQUE
#
class Product < ApplicationRecord
  has_many :product_cart_mappings
  has_many :carts, through: :product_cart_mappings
  has_many :product_order_mappings
  has_many :orders, through: :product_order_mappings
end
