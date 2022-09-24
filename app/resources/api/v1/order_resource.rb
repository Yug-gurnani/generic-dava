# frozen_string_literal: true

module Api
  module V1
    # Order Resource
    class OrderResource < JSONAPI::Resource
      caching
      attributes :user_id, :delivered, :order_details
      filter :user_id

      paginator :paged

      def order_details
        products = ProductOrderMapping.where(order_id: @model.id).pluck(:product_id, :quantity)
        data = []
        products.each do |product|
          product_id = product[0]
          product_quantity = product[1]
          product_attributes = Product.find_by_id(product_id).attributes

          data << { product_details: product_attributes, product_quantity: product_quantity }
        end
        data
      end
    end
  end
end
