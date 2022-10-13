# frozen_string_literal: true

module Api
  module V1
    # Orders Controller
    class OrdersController < ApiController
      include JSONAPI::ActsAsResourceController
      before_action :access_auth, only: %i[update destroy]

      def context
        {
          user: current_user
        }
      end

      def index
        orders = Order.where(user_id: current_user.id)
        data = []
        orders.each do |order|
          mappings = ProductOrderMapping.where(order_id: order.id)
          mappings.each do |mapping|
            product_id = mapping.product_id
            product_quantity = mapping.quantity
            product_attributes = Product.find_by_id(product_id).attributes

            data << { id: order.id, delivered: order.delivered, created_at: order.created_at, unique_id: mapping.id, product_details: product_attributes, product_quantity: product_quantity }
          end
        end
        render json: { data: data.sort_by { |x| x[:id] }.reverse }, status: :ok
      end

      def create
        order = Order.create!(user_id: current_user.id)

        order_details = params[:data][:attributes][:products]
        order_details.each do |product_id, quantity|
          pom = ProductOrderMapping.find_or_create_by(product_id: product_id, order_id: order.id)
          pom.update!(quantity: quantity)
        end

        OrderMailer.with(order: order, order_details: order_details.permit!).new_order_email.deliver_later
        render_success({ message: 'Order Placed Succesfully!' })
      end

      private

      def access_auth
        render_unauthorized unless params[:user_id].to_i == current_user.id || current_user.admin?
      end
    end
  end
end
