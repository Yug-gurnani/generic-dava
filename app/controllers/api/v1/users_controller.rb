# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController
      include JSONAPI::ActsAsResourceController
      before_action :admin_auth, only: %i[index]
      before_action :update_auth, only: %i[update]

      def verify_user
        referral_code = params[:referral_code]
        referral = Referral.find_by(referral_code: referral_code)
        if referral.present?
          return render_error({ message: 'Referral Code Already Used' }) if referral.used?

          current_user.update!(verified: true)
          referral.update!(used: true, referred_user_id: current_user.id)
          render_success({ message: 'User Verified Succesfully!' })
        else
          render_error({ message: 'Invalid Referral Code.' })
        end
      end

      def update_products_in_cart
        cart = Cart.find_by(user_id: current_user.id)
        return render_error({ message: 'Cart Not found!' }) if cart.blank?

        products = params[:data][:attributes][:products]
        products.each do |product_id, quantity|
          pcm = ProductCartMapping.find_or_create_by(product_id: product_id, cart_id: cart.id)
          pcm.update!(quantity: quantity)
        end

        render_success({ message: 'Cart Updated Succesfully!' })
      end

      def cart_details
        render_success({ cart_details: current_user.cart_details })
      end

      private

      def update_auth
        render_unauthorized if current_user.id != params[:id].to_i

        true
      end
    end
  end
end
