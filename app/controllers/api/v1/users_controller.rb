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
          if quantity <= 0
            pcm = ProductCartMapping.find_by(product_id: product_id, cart_id: cart.id)
            pcm.destroy if pcm.present?
          else
            pcm = ProductCartMapping.find_or_create_by(product_id: product_id, cart_id: cart.id)
            pcm.update!(quantity: quantity)
          end
        end

        render_success({ message: 'Cart Updated Succesfully!', cart_details: current_user.cart_details })
      end

      def cart_details
        render_success({ cart_details: current_user.cart_details })
      end

      def login
        code = params['code']
        google_id = params['googleId']
        return render_error({ message: 'google_id parameter not specified' }) if google_id.blank?

        user = User.fetch_google_user(code, google_id)

        if user.present?
          sign_in(user)
          return render_success(user.as_json.merge({ "type": 'users' })) if current_user.present?
        end
        render_error({ message: 'Error occured while authenticating' })
      end

      private

      def update_auth
        render_unauthorized if current_user.id != params[:id].to_i

        true
      end
    end
  end
end
