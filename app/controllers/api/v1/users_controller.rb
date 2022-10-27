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
        to_be_destroyed = []
        products.each do |product_id, quantity|
          if quantity <= 0
            to_be_destroyed << product_id
          else
            pcm = ProductCartMapping.find_or_create_by(cart_id: cart.id, product_id: product_id)
            pcm.update!(quantity: quantity)
          end
        end
        ProductCartMapping.where(product_id: to_be_destroyed).destroy_all

        render_success({ message: 'Cart Updated Succesfully!', cart_details: current_user.cart_details })
      end

      def cart_details
        render_success({ cart_details: current_user.cart_details })
      end

      def login
        access_token = params['access_token']
        return render_error({ message: 'access_token parameter not specified' }) if access_token.blank?

        user = User.fetch_google_user(access_token)

        if user.present?
          sign_in(user)
          return render_success(user.as_json.merge({ "type": 'users' })) if current_user.present?
        end
        render_error({ message: 'Error occured while authenticating' })
      end

      def logout
        sign_out(current_user)

        render_success({ message: 'Logged Out Succesfully!' })
      end

      private

      def update_auth
        render_unauthorized if current_user.id != params[:id].to_i

        true
      end
    end
  end
end
