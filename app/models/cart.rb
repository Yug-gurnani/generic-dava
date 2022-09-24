# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_carts_on_user_id  (user_id) UNIQUE
#
class Cart < ApplicationRecord
  belongs_to :user
  has_many :product_cart_mappings, dependent: :destroy
  has_many :products, through: :product_cart_mappings
end
