# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include JSONAPI::ActsAsResourceController
      before_action :admin_auth, only: %i[index]
      before_action :update_auth, only: %i[update]

      def verify_user
        referral_code = params[:referral_code]
        referral = Referral.find_by(referral_code: referral_code)
        if referral.present?
          return render_error({ message: 'Referral Code Already Used' }) if referral.used?

          current_user.update!(verified: true)
          referral.update!(used: true)
          render_success({ message: 'User Verified Succesfully!' })
        else
          render_error({ message: 'Invalid Referral Code.' })
        end
      end

      private

      def update_auth
        render_unauthorized if current_user.id != params[:id].to_i

        true
      end
    end
  end
end
