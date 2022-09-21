# frozen_string_literal: true

module Api
  module V1
    # Product Resource
    class ProductResource < JSONAPI::Resource
      attributes :name, :description, :max_price, :selling_price, :image_url, :total_stock, :created_at, :updated_at
    end
  end
end
