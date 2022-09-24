# frozen_string_literal: true

module Api
  module V1
    # Product Resource
    class ProductResource < JSONAPI::Resource
      caching
      attributes :name, :description, :max_price, :selling_price, :image_url, :total_stock, :created_at, :updated_at

      paginator :paged
    end
  end
end
