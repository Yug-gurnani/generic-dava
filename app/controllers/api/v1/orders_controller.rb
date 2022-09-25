# frozen_string_literal: true

module Api
  module V1
    # Orders Controller
    class OrdersController < ApiController
      include JSONAPI::ActsAsResourceController
      before_action :access_auth, only: %i[show index update destroy]

      def context
        {
          user: current_user
        }
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
        render_unauthorized unless params.dig(:filter, :user_id).to_i == current_user.id || current_user.admin?
      end
    end
  end
end
