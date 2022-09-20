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
#  quantity      :integer          default(0)
#  selling_price :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_products_on_name  (name) UNIQUE
#
class Product < ApplicationRecord
end
