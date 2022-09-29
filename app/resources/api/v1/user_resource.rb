# frozen_string_literal: true

module Api
  module V1
    class UserResource < JSONAPI::Resource
      attributes :email, :name, :google_id, :image_url, :phone_number, :user_type, :verified, :address

      def self.updatable_fields(context)
        super - [:verified]
      end

      def self.creatable_fields(context)
        super - [:verified]
      end
    end
  end
end
