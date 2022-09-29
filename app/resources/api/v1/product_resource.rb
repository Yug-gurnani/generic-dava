# frozen_string_literal: true

module Api
  module V1
    # Product Resource
    class ProductResource < JSONAPI::Resource
      caching
      attributes :name, :description, :max_price, :selling_price, :image_url, :total_stock, :category, :created_at, :updated_at

      paginator :paged
      filter :category
      filter :name, apply: lambda { |records, value, _options|
        records.where('name LIKE ?', "#{value[0]}%")
      }
    end
  end
end
